// # Proxy Compiler 18.3.1-fe2cc6-20180517

import Foundation
import SAPOData

open class Travelexpense<Provider: DataServiceProvider>: DataService<Provider> {
    public override init(provider: Provider) {
        super.init(provider: provider)
        self.provider.metadata = TravelexpenseMetadata.document
    }

    @available(swift, deprecated: 4.0, renamed: "fetchCurrency")
    open func currency(query: DataQuery = DataQuery()) throws -> Array<CurrencyType> {
        return try self.fetchCurrency(matching: query)
    }

    @available(swift, deprecated: 4.0, renamed: "fetchCurrency")
    open func currency(query: DataQuery = DataQuery(), completionHandler: @escaping (Array<CurrencyType>?, Error?) -> Void) {
        self.fetchCurrency(matching: query, completionHandler: completionHandler)
    }

    @available(swift, deprecated: 4.0, renamed: "fetchExpense")
    open func expense(query: DataQuery = DataQuery()) throws -> Array<ExpenseType> {
        return try self.fetchExpense(matching: query)
    }

    @available(swift, deprecated: 4.0, renamed: "fetchExpense")
    open func expense(query: DataQuery = DataQuery(), completionHandler: @escaping (Array<ExpenseType>?, Error?) -> Void) {
        self.fetchExpense(matching: query, completionHandler: completionHandler)
    }

    @available(swift, deprecated: 4.0, renamed: "fetchExpenseItem")
    open func expenseItem(query: DataQuery = DataQuery()) throws -> Array<ExpenseItemType> {
        return try self.fetchExpenseItem(matching: query)
    }

    @available(swift, deprecated: 4.0, renamed: "fetchExpenseItem")
    open func expenseItem(query: DataQuery = DataQuery(), completionHandler: @escaping (Array<ExpenseItemType>?, Error?) -> Void) {
        self.fetchExpenseItem(matching: query, completionHandler: completionHandler)
    }

    @available(swift, deprecated: 4.0, renamed: "fetchExpenseReportItem")
    open func expenseReportItem(query: DataQuery = DataQuery()) throws -> Array<ExpenseReportItemType> {
        return try self.fetchExpenseReportItem(matching: query)
    }

    @available(swift, deprecated: 4.0, renamed: "fetchExpenseReportItem")
    open func expenseReportItem(query: DataQuery = DataQuery(), completionHandler: @escaping (Array<ExpenseReportItemType>?, Error?) -> Void) {
        self.fetchExpenseReportItem(matching: query, completionHandler: completionHandler)
    }

    open func fetchCurrency(matching query: DataQuery = DataQuery()) throws -> Array<CurrencyType> {
        return try CurrencyType.array(from: self.executeQuery(query.fromDefault(TravelexpenseMetadata.EntitySets.currency)).entityList())
    }

    open func fetchCurrency(matching query: DataQuery = DataQuery(), completionHandler: @escaping (Array<CurrencyType>?, Error?) -> Void) {
        self.addBackgroundOperation {
            do {
                let result: Array<CurrencyType> = try self.fetchCurrency(matching: query)
                self.completionQueue.addOperation {
                    completionHandler(result, nil)
                }
            } catch let error {
                self.completionQueue.addOperation {
                    completionHandler(nil, error)
                }
            }
        }
    }

    open func fetchCurrencyType(matching query: DataQuery) throws -> CurrencyType {
        return try CastRequired<CurrencyType>.from(self.executeQuery(query.fromDefault(TravelexpenseMetadata.EntitySets.currency)).requiredEntity())
    }

    open func fetchCurrencyType(matching query: DataQuery, completionHandler: @escaping (CurrencyType?, Error?) -> Void) {
        self.addBackgroundOperation {
            do {
                let result: CurrencyType = try self.fetchCurrencyType(matching: query)
                self.completionQueue.addOperation {
                    completionHandler(result, nil)
                }
            } catch let error {
                self.completionQueue.addOperation {
                    completionHandler(nil, error)
                }
            }
        }
    }

    open func fetchExpense(matching query: DataQuery = DataQuery()) throws -> Array<ExpenseType> {
        return try ExpenseType.array(from: self.executeQuery(query.fromDefault(TravelexpenseMetadata.EntitySets.expense)).entityList())
    }

    open func fetchExpense(matching query: DataQuery = DataQuery(), completionHandler: @escaping (Array<ExpenseType>?, Error?) -> Void) {
        self.addBackgroundOperation {
            do {
                let result: Array<ExpenseType> = try self.fetchExpense(matching: query)
                self.completionQueue.addOperation {
                    completionHandler(result, nil)
                }
            } catch let error {
                self.completionQueue.addOperation {
                    completionHandler(nil, error)
                }
            }
        }
    }

    open func fetchExpenseItem(matching query: DataQuery = DataQuery()) throws -> Array<ExpenseItemType> {
        return try ExpenseItemType.array(from: self.executeQuery(query.fromDefault(TravelexpenseMetadata.EntitySets.expenseItem)).entityList())
    }

    open func fetchExpenseItem(matching query: DataQuery = DataQuery(), completionHandler: @escaping (Array<ExpenseItemType>?, Error?) -> Void) {
        self.addBackgroundOperation {
            do {
                let result: Array<ExpenseItemType> = try self.fetchExpenseItem(matching: query)
                self.completionQueue.addOperation {
                    completionHandler(result, nil)
                }
            } catch let error {
                self.completionQueue.addOperation {
                    completionHandler(nil, error)
                }
            }
        }
    }

    open func fetchExpenseItemType(matching query: DataQuery) throws -> ExpenseItemType {
        return try CastRequired<ExpenseItemType>.from(self.executeQuery(query.fromDefault(TravelexpenseMetadata.EntitySets.expenseItem)).requiredEntity())
    }

    open func fetchExpenseItemType(matching query: DataQuery, completionHandler: @escaping (ExpenseItemType?, Error?) -> Void) {
        self.addBackgroundOperation {
            do {
                let result: ExpenseItemType = try self.fetchExpenseItemType(matching: query)
                self.completionQueue.addOperation {
                    completionHandler(result, nil)
                }
            } catch let error {
                self.completionQueue.addOperation {
                    completionHandler(nil, error)
                }
            }
        }
    }

    open func fetchExpenseReportItem(matching query: DataQuery = DataQuery()) throws -> Array<ExpenseReportItemType> {
        return try ExpenseReportItemType.array(from: self.executeQuery(query.fromDefault(TravelexpenseMetadata.EntitySets.expenseReportItem)).entityList())
    }

    open func fetchExpenseReportItem(matching query: DataQuery = DataQuery(), completionHandler: @escaping (Array<ExpenseReportItemType>?, Error?) -> Void) {
        self.addBackgroundOperation {
            do {
                let result: Array<ExpenseReportItemType> = try self.fetchExpenseReportItem(matching: query)
                self.completionQueue.addOperation {
                    completionHandler(result, nil)
                }
            } catch let error {
                self.completionQueue.addOperation {
                    completionHandler(nil, error)
                }
            }
        }
    }

    open func fetchExpenseReportItemType(matching query: DataQuery) throws -> ExpenseReportItemType {
        return try CastRequired<ExpenseReportItemType>.from(self.executeQuery(query.fromDefault(TravelexpenseMetadata.EntitySets.expenseReportItem)).requiredEntity())
    }

    open func fetchExpenseReportItemType(matching query: DataQuery, completionHandler: @escaping (ExpenseReportItemType?, Error?) -> Void) {
        self.addBackgroundOperation {
            do {
                let result: ExpenseReportItemType = try self.fetchExpenseReportItemType(matching: query)
                self.completionQueue.addOperation {
                    completionHandler(result, nil)
                }
            } catch let error {
                self.completionQueue.addOperation {
                    completionHandler(nil, error)
                }
            }
        }
    }

    open func fetchExpenseType(matching query: DataQuery) throws -> ExpenseType {
        return try CastRequired<ExpenseType>.from(self.executeQuery(query.fromDefault(TravelexpenseMetadata.EntitySets.expense)).requiredEntity())
    }

    open func fetchExpenseType(matching query: DataQuery, completionHandler: @escaping (ExpenseType?, Error?) -> Void) {
        self.addBackgroundOperation {
            do {
                let result: ExpenseType = try self.fetchExpenseType(matching: query)
                self.completionQueue.addOperation {
                    completionHandler(result, nil)
                }
            } catch let error {
                self.completionQueue.addOperation {
                    completionHandler(nil, error)
                }
            }
        }
    }

    open func fetchPayment(matching query: DataQuery = DataQuery()) throws -> Array<PaymentType> {
        return try PaymentType.array(from: self.executeQuery(query.fromDefault(TravelexpenseMetadata.EntitySets.payment)).entityList())
    }

    open func fetchPayment(matching query: DataQuery = DataQuery(), completionHandler: @escaping (Array<PaymentType>?, Error?) -> Void) {
        self.addBackgroundOperation {
            do {
                let result: Array<PaymentType> = try self.fetchPayment(matching: query)
                self.completionQueue.addOperation {
                    completionHandler(result, nil)
                }
            } catch let error {
                self.completionQueue.addOperation {
                    completionHandler(nil, error)
                }
            }
        }
    }

    open func fetchPaymentType(matching query: DataQuery) throws -> PaymentType {
        return try CastRequired<PaymentType>.from(self.executeQuery(query.fromDefault(TravelexpenseMetadata.EntitySets.payment)).requiredEntity())
    }

    open func fetchPaymentType(matching query: DataQuery, completionHandler: @escaping (PaymentType?, Error?) -> Void) {
        self.addBackgroundOperation {
            do {
                let result: PaymentType = try self.fetchPaymentType(matching: query)
                self.completionQueue.addOperation {
                    completionHandler(result, nil)
                }
            } catch let error {
                self.completionQueue.addOperation {
                    completionHandler(nil, error)
                }
            }
        }
    }

    open func fetchReportStatus(matching query: DataQuery = DataQuery()) throws -> Array<ReportStatusType> {
        return try ReportStatusType.array(from: self.executeQuery(query.fromDefault(TravelexpenseMetadata.EntitySets.reportStatus)).entityList())
    }

    open func fetchReportStatus(matching query: DataQuery = DataQuery(), completionHandler: @escaping (Array<ReportStatusType>?, Error?) -> Void) {
        self.addBackgroundOperation {
            do {
                let result: Array<ReportStatusType> = try self.fetchReportStatus(matching: query)
                self.completionQueue.addOperation {
                    completionHandler(result, nil)
                }
            } catch let error {
                self.completionQueue.addOperation {
                    completionHandler(nil, error)
                }
            }
        }
    }

    open func fetchReportStatusType(matching query: DataQuery) throws -> ReportStatusType {
        return try CastRequired<ReportStatusType>.from(self.executeQuery(query.fromDefault(TravelexpenseMetadata.EntitySets.reportStatus)).requiredEntity())
    }

    open func fetchReportStatusType(matching query: DataQuery, completionHandler: @escaping (ReportStatusType?, Error?) -> Void) {
        self.addBackgroundOperation {
            do {
                let result: ReportStatusType = try self.fetchReportStatusType(matching: query)
                self.completionQueue.addOperation {
                    completionHandler(result, nil)
                }
            } catch let error {
                self.completionQueue.addOperation {
                    completionHandler(nil, error)
                }
            }
        }
    }

    open func fetchReservation(matching query: DataQuery = DataQuery()) throws -> Array<ReservationType> {
        return try ReservationType.array(from: self.executeQuery(query.fromDefault(TravelexpenseMetadata.EntitySets.reservation)).entityList())
    }

    open func fetchReservation(matching query: DataQuery = DataQuery(), completionHandler: @escaping (Array<ReservationType>?, Error?) -> Void) {
        self.addBackgroundOperation {
            do {
                let result: Array<ReservationType> = try self.fetchReservation(matching: query)
                self.completionQueue.addOperation {
                    completionHandler(result, nil)
                }
            } catch let error {
                self.completionQueue.addOperation {
                    completionHandler(nil, error)
                }
            }
        }
    }

    open func fetchReservationItem(matching query: DataQuery = DataQuery()) throws -> Array<ReservationItemType> {
        return try ReservationItemType.array(from: self.executeQuery(query.fromDefault(TravelexpenseMetadata.EntitySets.reservationItem)).entityList())
    }

    open func fetchReservationItem(matching query: DataQuery = DataQuery(), completionHandler: @escaping (Array<ReservationItemType>?, Error?) -> Void) {
        self.addBackgroundOperation {
            do {
                let result: Array<ReservationItemType> = try self.fetchReservationItem(matching: query)
                self.completionQueue.addOperation {
                    completionHandler(result, nil)
                }
            } catch let error {
                self.completionQueue.addOperation {
                    completionHandler(nil, error)
                }
            }
        }
    }

    open func fetchReservationItemType(matching query: DataQuery) throws -> ReservationItemType {
        return try CastRequired<ReservationItemType>.from(self.executeQuery(query.fromDefault(TravelexpenseMetadata.EntitySets.reservationItem)).requiredEntity())
    }

    open func fetchReservationItemType(matching query: DataQuery, completionHandler: @escaping (ReservationItemType?, Error?) -> Void) {
        self.addBackgroundOperation {
            do {
                let result: ReservationItemType = try self.fetchReservationItemType(matching: query)
                self.completionQueue.addOperation {
                    completionHandler(result, nil)
                }
            } catch let error {
                self.completionQueue.addOperation {
                    completionHandler(nil, error)
                }
            }
        }
    }

    open func fetchReservationType(matching query: DataQuery) throws -> ReservationType {
        return try CastRequired<ReservationType>.from(self.executeQuery(query.fromDefault(TravelexpenseMetadata.EntitySets.reservation)).requiredEntity())
    }

    open func fetchReservationType(matching query: DataQuery, completionHandler: @escaping (ReservationType?, Error?) -> Void) {
        self.addBackgroundOperation {
            do {
                let result: ReservationType = try self.fetchReservationType(matching: query)
                self.completionQueue.addOperation {
                    completionHandler(result, nil)
                }
            } catch let error {
                self.completionQueue.addOperation {
                    completionHandler(nil, error)
                }
            }
        }
    }

    open func fetchTripItem(matching query: DataQuery = DataQuery()) throws -> Array<TripItemType> {
        return try TripItemType.array(from: self.executeQuery(query.fromDefault(TravelexpenseMetadata.EntitySets.tripItem)).entityList())
    }

    open func fetchTripItem(matching query: DataQuery = DataQuery(), completionHandler: @escaping (Array<TripItemType>?, Error?) -> Void) {
        self.addBackgroundOperation {
            do {
                let result: Array<TripItemType> = try self.fetchTripItem(matching: query)
                self.completionQueue.addOperation {
                    completionHandler(result, nil)
                }
            } catch let error {
                self.completionQueue.addOperation {
                    completionHandler(nil, error)
                }
            }
        }
    }

    open func fetchTripItemType(matching query: DataQuery) throws -> TripItemType {
        return try CastRequired<TripItemType>.from(self.executeQuery(query.fromDefault(TravelexpenseMetadata.EntitySets.tripItem)).requiredEntity())
    }

    open func fetchTripItemType(matching query: DataQuery, completionHandler: @escaping (TripItemType?, Error?) -> Void) {
        self.addBackgroundOperation {
            do {
                let result: TripItemType = try self.fetchTripItemType(matching: query)
                self.completionQueue.addOperation {
                    completionHandler(result, nil)
                }
            } catch let error {
                self.completionQueue.addOperation {
                    completionHandler(nil, error)
                }
            }
        }
    }

    @available(swift, deprecated: 4.0, renamed: "fetchPayment")
    open func payment(query: DataQuery = DataQuery()) throws -> Array<PaymentType> {
        return try self.fetchPayment(matching: query)
    }

    @available(swift, deprecated: 4.0, renamed: "fetchPayment")
    open func payment(query: DataQuery = DataQuery(), completionHandler: @escaping (Array<PaymentType>?, Error?) -> Void) {
        self.fetchPayment(matching: query, completionHandler: completionHandler)
    }

    open override func refreshMetadata() throws {
        objc_sync_enter(self)
        defer { objc_sync_exit(self) }
        do {
            try ProxyInternal.refreshMetadata(service: self, fetcher: nil, options: TravelexpenseMetadataParser.options)
            TravelexpenseMetadataChanges.merge(metadata: self.metadata)
        }
    }

    @available(swift, deprecated: 4.0, renamed: "fetchReportStatus")
    open func reportStatus(query: DataQuery = DataQuery()) throws -> Array<ReportStatusType> {
        return try self.fetchReportStatus(matching: query)
    }

    @available(swift, deprecated: 4.0, renamed: "fetchReportStatus")
    open func reportStatus(query: DataQuery = DataQuery(), completionHandler: @escaping (Array<ReportStatusType>?, Error?) -> Void) {
        self.fetchReportStatus(matching: query, completionHandler: completionHandler)
    }

    @available(swift, deprecated: 4.0, renamed: "fetchReservation")
    open func reservation(query: DataQuery = DataQuery()) throws -> Array<ReservationType> {
        return try self.fetchReservation(matching: query)
    }

    @available(swift, deprecated: 4.0, renamed: "fetchReservation")
    open func reservation(query: DataQuery = DataQuery(), completionHandler: @escaping (Array<ReservationType>?, Error?) -> Void) {
        self.fetchReservation(matching: query, completionHandler: completionHandler)
    }

    @available(swift, deprecated: 4.0, renamed: "fetchReservationItem")
    open func reservationItem(query: DataQuery = DataQuery()) throws -> Array<ReservationItemType> {
        return try self.fetchReservationItem(matching: query)
    }

    @available(swift, deprecated: 4.0, renamed: "fetchReservationItem")
    open func reservationItem(query: DataQuery = DataQuery(), completionHandler: @escaping (Array<ReservationItemType>?, Error?) -> Void) {
        self.fetchReservationItem(matching: query, completionHandler: completionHandler)
    }

    @available(swift, deprecated: 4.0, renamed: "fetchTripItem")
    open func tripItem(query: DataQuery = DataQuery()) throws -> Array<TripItemType> {
        return try self.fetchTripItem(matching: query)
    }

    @available(swift, deprecated: 4.0, renamed: "fetchTripItem")
    open func tripItem(query: DataQuery = DataQuery(), completionHandler: @escaping (Array<TripItemType>?, Error?) -> Void) {
        self.fetchTripItem(matching: query, completionHandler: completionHandler)
    }
}
