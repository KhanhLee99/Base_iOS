//
//  PagingTableView.swift
//
//

import UIKit
import RxCocoa
import RxSwift
import MJRefresh
import RxDataSources

class PagingTableView: UITableView {
    private let _refreshControl = UIRefreshControl()
    
    open var isRefreshing: Binder<Bool> {
        return Binder(self) { tableView, loading in
            if tableView.refreshHeader == nil {
                if loading {
                    tableView._refreshControl.beginRefreshing()
                } else {
                    if tableView._refreshControl.isRefreshing {
                        tableView._refreshControl.endRefreshing()
                    }
                }
            } else {
                if loading {
                    tableView.mj_header?.beginRefreshing()
                } else {
                    tableView.mj_header?.endRefreshing()
                }
            }
        }
    }
    
    var isLoadingMore: Binder<Bool> {
        return Binder(self) { tableView, loading in
            if loading {
                tableView.mj_footer?.beginRefreshing()
            } else {
                tableView.mj_footer?.endRefreshing()
            }
        }
    }
    
    private var _refreshTrigger = PublishSubject<Void>()
    
    open var refreshTrigger: Driver<Void> {
        if refreshHeader == nil {
            return _refreshControl.rx.controlEvent(.valueChanged).asDriver()
        } else {
            return _refreshTrigger.asDriver(onErrorJustReturn: ())
        }
    }
    
    private var _loadMoreTrigger = PublishSubject<Void>()
    
    var loadMoreTrigger: Driver<Void> {
        _loadMoreTrigger.asDriver(onErrorJustReturn: ())
    }
    
    var refreshHeader: MJRefreshHeader? {
        didSet {
            mj_header = refreshHeader
            mj_header?.refreshingBlock = { [weak self] in
                self?._refreshTrigger.onNext(())
            }
            
            removeRefreshControl()
        }
    }
    
    var refreshFooter: MJRefreshFooter? {
        didSet {
            mj_footer = refreshFooter
            mj_footer?.refreshingBlock = { [weak self] in
                self?._loadMoreTrigger.onNext(())
            }
        }
    }
    
    override open func awakeFromNib() {
        super.awakeFromNib()
        refreshFooter = RefreshAutoFooter()
        refreshHeader = RefreshAutoHeader()
    }
    
    func addRefreshControl() {
        guard !self.subviews.contains(_refreshControl) else { return }
        
        refreshHeader = nil
        addSubview(_refreshControl)
    }
    
    func removeRefreshControl() {
        _refreshControl.removeFromSuperview()
    }
}
