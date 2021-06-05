//  Created by Liza Kryshkovskaya on 4.06.21.

import Foundation

final class CallStation {
    var callsArray: [Call] = []
    var usersArray: [User] = []
}

extension CallStation: Station {
    func users() -> [User] {
        return usersArray
    }
    
    func add(user: User) {
        if !(usersArray.contains(user)){
            usersArray.append(user)
        }
    }
    
    func remove(user: User) {
        if usersArray.contains(user){
            usersArray.remove(at: usersArray.firstIndex(of: user)!)
        }
    }
    
    func execute(action: CallAction) -> CallID? {
        switch action {
        
        case .answer(let user):
            let call = currentCall(user: user)
            
            if !usersArray.contains(user) {
                modifyCall(call: call!, with: .ended(reason: .error))
                return nil
            }
            
            modifyCall(call: call!, with: .talk)
            return call?.id
            
        case .end(let user):
            let call = currentCall(user: user)
            switch call?.status {
            case .talk:
                modifyCall(call: call!, with: .ended(reason: .end))
            case .calling:
                modifyCall(call: call!, with: .ended(reason: .cancel))
            default:
                return call?.id
            }
            return call?.id
            
        case .start(let user1, let user2):
            // проверяем, существует ли звонящий
            if !usersArray.contains(user1) {
                return nil
            }
            // проверяем, существует ли целевой юзер
            if !usersArray.contains(user2) {
                let newCall = Call(id: UUID(), incomingUser: user1, outgoingUser: user2, status: .ended(reason: .error))
                callsArray.append(newCall)
                return newCall.id
            }
            
            // проверяем, занят ли user2, и если да, создаем звонок сразу со статусом busy
            if currentCall(user: user2) != nil {
                let newCall = Call(id: UUID(), incomingUser: user1, outgoingUser: user2, status: .ended(reason: .userBusy))
                callsArray.append(newCall)
                return newCall.id
            }
                
            let newCall = Call(id: UUID(), incomingUser: user1, outgoingUser: user2, status: .calling)
            callsArray.append(newCall)
            return newCall.id
        }
    }
    
    func calls() -> [Call] {
        return callsArray
    }
    
    func calls(user: User) -> [Call] {
        return callsArray.filter{ $0.incomingUser.id == user.id || $0.outgoingUser.id == user.id}
    }
    
    func call(id: CallID) -> Call? {
        return callsArray.first(where: {$0.id == id})
    }
    
    func currentCall(user: User) -> Call? {
        return callsArray.first(where: {($0.incomingUser.id == user.id || $0.outgoingUser.id == user.id) && ($0.status == .calling || $0.status == .talk)})
    }
    
    func modifyCall(call: Call, with status: CallStatus) {
        // удаляем старый звонок
        if callsArray.contains(where: {$0.id == call.id}){
            callsArray.remove(at: callsArray.firstIndex(where: {$0.id == call.id})!)
        }
        // добавляем с обновленным статусом
        callsArray.append(Call(id: call.id, incomingUser: call.incomingUser, outgoingUser: call.outgoingUser, status: status))
    }
}
