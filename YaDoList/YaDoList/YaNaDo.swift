//
//  YaNaDo.swift
//  YaDoList
//
//  Created by HongYeol on 2020/07/28.
//  Copyright © 2020 HY. All rights reserved.
//

import UIKit

struct YaNaDo: Codable, Equatable {
    let id: Int
    var isDone: Bool
    var detail: String
    var isToday: Bool
    
    mutating func update(isDone: Bool, detail: String, isToday: Bool) {
        self.isDone = isDone
        self.detail = detail
        self.isToday = isToday
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.id == rhs.id
    }
}

class YaNaDoManager {
    static let shared = YaNaDoManager()
    
    static var lastId: Int = 0
    
    var yanados:[YaNaDo] = []
    
    func createYaNaDo(detail: String, isToday: Bool) -> YaNaDo {
        let nextId: Int = YaNaDoManager.lastId + 1
        YaNaDoManager.lastId = nextId
        print("Self.lastId = \(Self.lastId), YaNaDoManager.lastId = \(YaNaDoManager.lastId)")
        return YaNaDo(id: Self.lastId-1, isDone: false, detail: detail, isToday: isToday)
    }
    
    func addYaNaDo(_ yanado: YaNaDo) {
        self.yanados.append(yanado)
        saveYaNaDo()
    }
    
    func deleteYaNaDo(_ yanado: YaNaDo) {
        //배열을 돌아가면서 전달받은 객체만 빼고 새로 만들자
        //filter
        
        self.yanados = self.yanados.filter {
            tempYaNaDo -> Bool in
            return tempYaNaDo.id != yanado.id
        }
        saveYaNaDo()
    }
    
    func updateYaNaDo(_ yanado: YaNaDo) {
        //YaNaDo가 Equatable을 준수하니까 firstIndex(of)가 사용가능함...그렇지 않으면 where로 구분해줘야함
        guard let index = yanados.firstIndex(of: yanado) else { return }
        yanados[index].update(isDone: yanado.isDone, detail: yanado.detail, isToday: yanado.isToday)
        saveYaNaDo()
    }
    
    func saveYaNaDo() {
        Storage.store(yanados, to: .documents, as: "todos.json")
    }

    func retrieveYaNaDo() {
        yanados = Storage.retrive("todos.json", from: .documents, as: [YaNaDo].self) ?? []
        
        let lastId = yanados.last?.id ?? 0
        YaNaDoManager.lastId = lastId
    }
}

class YaNaDoViewModel {
    enum Section: Int, CaseIterable {
        case today
        case upcoming
        
        var title: String {
            switch self {
                case .today: return "Today"
                default: return "Upcoming"
            }
        }
    }
    private let manager = YaNaDoManager.shared
    
    var yanados:[YaNaDo] {
        return manager.yanados
    }
    
    var todayYaNaDo:[YaNaDo] {
        return yanados.filter({yanado -> Bool in return yanado.isToday == true})
        //return manager.yanados.filter{$0.isToday == true}
    }
    
    var upcomingYaNaDo:[YaNaDo] {
        return yanados.filter { $0.isToday == false }
    }
    
    var numOfSection:Int {
        return Section.allCases.count
    }
    
    func addYaNaDo(_ yanado: YaNaDo) {
        manager.addYaNaDo(yanado)
    }
    
    func delteYaNaDo(_ yanado: YaNaDo) {
        manager.deleteYaNaDo(yanado)
    }
    
    func updateYaNaDo(_ yanado: YaNaDo) {
        manager.updateYaNaDo(yanado)
    }
    
    func loadTasks() {
        manager.retrieveYaNaDo()
    }
}

