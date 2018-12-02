// # Proxy Compiler 18.9.2-6abc59-20180924

import Foundation
import SAPOData

open class Travelexpense<Provider: DataServiceProvider>: DataService<Provider> {
    public override init(provider: Provider) {
        super.init(provider: provider)
        self.provider.metadata = TravelexpenseMetadata.document
    }

    @available(swift, deprecated: 4.0, renamed: "fetchCurrencies")
    open func currencies(query: DataQuery = DataQuery()) throws -> Array<Currency> {
        return try self.fetchCurrencies(matching: query)
    }

    @available(swift, deprecated: 4.0, renamed: "fetchCurrencies")
    open func currencies(query: DataQuery = DataQuery(), completionHandler: @escaping (Array<Currency>?, Error?) -> Void) {
        self.fetchCurrencies(matching: query, headers: nil, options: nil, completionHandler: completionHandler)
    }

    @available(swift, deprecated: 4.0, renamed: "fetchExpenseItemAttachments")
    open func expenseItemAttachments(query: DataQuery = DataQuery()) throws -> Array<ExpenseItemAttachment> {
        return try self.fetchExpenseItemAttachments(matching: query)
    }

    @available(swift, deprecated: 4.0, renamed: "fetchExpenseItemAttachments")
    open func expenseItemAttachments(query: DataQuery = DataQuery(), completionHandler: @escaping (Array<ExpenseItemAttachment>?, Error?) -> Void) {
        self.fetchExpenseItemAttachments(matching: query, headers: nil, options: nil, completionHandler: completionHandler)
    }

    @available(swift, deprecated: 4.0, renamed: "fetchExpenseItems")
    open func expenseItems(query: DataQuery = DataQuery()) throws -> Array<ExpenseItem> {
        return try self.fetchExpenseItems(matching: query)
    }

    @available(swift, deprecated: 4.0, renamed: "fetchExpenseItems")
    open func expenseItems(query: DataQuery = DataQuery(), completionHandler: @escaping (Array<ExpenseItem>?, Error?) -> Void) {
        self.fetchExpenseItems(matching: query, headers: nil, options: nil, completionHandler: completionHandler)
    }

    @available(swift, deprecated: 4.0, renamed: "fetchExpenseReports")
    open func expenseReports(query: DataQuery = DataQuery()) throws -> Array<ExpenseReportItem> {
        return try self.fetchExpenseReports(matching: query)
    }

    @available(swift, deprecated: 4.0, renamed: "fetchExpenseReports")
    open func expenseReports(query: DataQuery = DataQuery(), completionHandler: @escaping (Array<ExpenseReportItem>?, Error?) -> Void) {
        self.fetchExpenseReports(matching: query, headers: nil, options: nil, completionHandler: completionHandler)
    }

    @available(swift, deprecated: 4.0, renamed: "fetchExpenses")
    open func expenses(query: DataQuery = DataQuery()) throws -> Array<Expense> {
        return try self.fetchExpenses(matching: query)
    }

    @available(swift, deprecated: 4.0, renamed: "fetchExpenses")
    open func expenses(query: DataQuery = DataQuery(), completionHandler: @escaping (Array<Expense>?, Error?) -> Void) {
        self.fetchExpenses(matching: query, headers: nil, options: nil, completionHandler: completionHandler)
    }

    open func fetchCurrencies(matching query: DataQuery? = nil, headers: HTTPHeaders? = nil, options: RequestOptions? = nil) throws -> Array<Currency> {
        let var_query: DataQuery = DataQuery.newIfNull(query: query)
        let var_headers: HTTPHeaders = HTTPHeaders.emptyIfNull(headers: headers)
        let var_options: RequestOptions = try RequestOptions.noneIfNull(options: options)
        return try Currency.array(from: self.executeQuery(var_query.fromDefault(TravelexpenseMetadata.EntitySets.currencies), headers: var_headers, options: var_options).entityList())
    }

    open func fetchCurrencies(matching query: DataQuery = DataQuery(), headers: HTTPHeaders? = nil, options: RequestOptions? = nil, completionHandler: @escaping (Array<Currency>?, Error?) -> Void) {
        self.addBackgroundOperationForFunction {
            do {
                let result: Array<Currency> = try self.fetchCurrencies(matching: query, headers: headers, options: options)
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

    open func fetchCurrency(matching query: DataQuery, headers: HTTPHeaders? = nil, options: RequestOptions? = nil) throws -> Currency {
        let var_headers: HTTPHeaders = HTTPHeaders.emptyIfNull(headers: headers)
        let var_options: RequestOptions = try RequestOptions.noneIfNull(options: options)
        return try CastRequired<Currency>.from(self.executeQuery(query.fromDefault(TravelexpenseMetadata.EntitySets.currencies), headers: var_headers, options: var_options).requiredEntity())
    }

    open func fetchCurrency(matching query: DataQuery, headers: HTTPHeaders? = nil, options: RequestOptions? = nil, completionHandler: @escaping (Currency?, Error?) -> Void) {
        self.addBackgroundOperationForFunction {
            do {
                let result: Currency = try self.fetchCurrency(matching: query, headers: headers, options: options)
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

    open func fetchExpense(matching query: DataQuery, headers: HTTPHeaders? = nil, options: RequestOptions? = nil) throws -> Expense {
        let var_headers: HTTPHeaders = HTTPHeaders.emptyIfNull(headers: headers)
        let var_options: RequestOptions = try RequestOptions.noneIfNull(options: options)
        return try CastRequired<Expense>.from(self.executeQuery(query.fromDefault(TravelexpenseMetadata.EntitySets.expenses), headers: var_headers, options: var_options).requiredEntity())
    }

    open func fetchExpense(matching query: DataQuery, headers: HTTPHeaders? = nil, options: RequestOptions? = nil, completionHandler: @escaping (Expense?, Error?) -> Void) {
        self.addBackgroundOperationForFunction {
            do {
                let result: Expense = try self.fetchExpense(matching: query, headers: headers, options: options)
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

    open func fetchExpenseItem(matching query: DataQuery, headers: HTTPHeaders? = nil, options: RequestOptions? = nil) throws -> ExpenseItem {
        let var_headers: HTTPHeaders = HTTPHeaders.emptyIfNull(headers: headers)
        let var_options: RequestOptions = try RequestOptions.noneIfNull(options: options)
        return try CastRequired<ExpenseItem>.from(self.executeQuery(query.fromDefault(TravelexpenseMetadata.EntitySets.expenseItems), headers: var_headers, options: var_options).requiredEntity())
    }

    open func fetchExpenseItem(matching query: DataQuery, headers: HTTPHeaders? = nil, options: RequestOptions? = nil, completionHandler: @escaping (ExpenseItem?, Error?) -> Void) {
        self.addBackgroundOperationForFunction {
            do {
                let result: ExpenseItem = try self.fetchExpenseItem(matching: query, headers: headers, options: options)
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

    open func fetchExpenseItemAttachment(matching query: DataQuery, headers: HTTPHeaders? = nil, options: RequestOptions? = nil) throws -> ExpenseItemAttachment {
        let var_headers: HTTPHeaders = HTTPHeaders.emptyIfNull(headers: headers)
        let var_options: RequestOptions = try RequestOptions.noneIfNull(options: options)
        return try CastRequired<ExpenseItemAttachment>.from(self.executeQuery(query.fromDefault(TravelexpenseMetadata.EntitySets.expenseItemAttachments), headers: var_headers, options: var_options).requiredEntity())
    }

    open func fetchExpenseItemAttachment(matching query: DataQuery, headers: HTTPHeaders? = nil, options: RequestOptions? = nil, completionHandler: @escaping (ExpenseItemAttachment?, Error?) -> Void) {
        self.addBackgroundOperationForFunction {
            do {
                let result: ExpenseItemAttachment = try self.fetchExpenseItemAttachment(matching: query, headers: headers, options: options)
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

    open func fetchExpenseItemAttachments(matching query: DataQuery? = nil, headers: HTTPHeaders? = nil, options: RequestOptions? = nil) throws -> Array<ExpenseItemAttachment> {
        let var_query: DataQuery = DataQuery.newIfNull(query: query)
        let var_headers: HTTPHeaders = HTTPHeaders.emptyIfNull(headers: headers)
        let var_options: RequestOptions = try RequestOptions.noneIfNull(options: options)
        return try ExpenseItemAttachment.array(from: self.executeQuery(var_query.fromDefault(TravelexpenseMetadata.EntitySets.expenseItemAttachments), headers: var_headers, options: var_options).entityList())
    }

    open func fetchExpenseItemAttachments(matching query: DataQuery = DataQuery(), headers: HTTPHeaders? = nil, options: RequestOptions? = nil, completionHandler: @escaping (Array<ExpenseItemAttachment>?, Error?) -> Void) {
        self.addBackgroundOperationForFunction {
            do {
                let result: Array<ExpenseItemAttachment> = try self.fetchExpenseItemAttachments(matching: query, headers: headers, options: options)
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

    open func fetchExpenseItems(matching query: DataQuery? = nil, headers: HTTPHeaders? = nil, options: RequestOptions? = nil) throws -> Array<ExpenseItem> {
        let var_query: DataQuery = DataQuery.newIfNull(query: query)
        let var_headers: HTTPHeaders = HTTPHeaders.emptyIfNull(headers: headers)
        let var_options: RequestOptions = try RequestOptions.noneIfNull(options: options)
        return try ExpenseItem.array(from: self.executeQuery(var_query.fromDefault(TravelexpenseMetadata.EntitySets.expenseItems), headers: var_headers, options: var_options).entityList())
    }

    open func fetchExpenseItems(matching query: DataQuery = DataQuery(), headers: HTTPHeaders? = nil, options: RequestOptions? = nil, completionHandler: @escaping (Array<ExpenseItem>?, Error?) -> Void) {
        self.addBackgroundOperationForFunction {
            do {
                let result: Array<ExpenseItem> = try self.fetchExpenseItems(matching: query, headers: headers, options: options)
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

    open func fetchExpenseReportItem(matching query: DataQuery, headers: HTTPHeaders? = nil, options: RequestOptions? = nil) throws -> ExpenseReportItem {
        let var_headers: HTTPHeaders = HTTPHeaders.emptyIfNull(headers: headers)
        let var_options: RequestOptions = try RequestOptions.noneIfNull(options: options)
        return try CastRequired<ExpenseReportItem>.from(self.executeQuery(query.fromDefault(TravelexpenseMetadata.EntitySets.expenseReports), headers: var_headers, options: var_options).requiredEntity())
    }

    open func fetchExpenseReportItem(matching query: DataQuery, headers: HTTPHeaders? = nil, options: RequestOptions? = nil, completionHandler: @escaping (ExpenseReportItem?, Error?) -> Void) {
        self.addBackgroundOperationForFunction {
            do {
                let result: ExpenseReportItem = try self.fetchExpenseReportItem(matching: query, headers: headers, options: options)
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

    open func fetchExpenseReports(matching query: DataQuery? = nil, headers: HTTPHeaders? = nil, options: RequestOptions? = nil) throws -> Array<ExpenseReportItem> {
        let var_query: DataQuery = DataQuery.newIfNull(query: query)
        let var_headers: HTTPHeaders = HTTPHeaders.emptyIfNull(headers: headers)
        let var_options: RequestOptions = try RequestOptions.noneIfNull(options: options)
        return try ExpenseReportItem.array(from: self.executeQuery(var_query.fromDefault(TravelexpenseMetadata.EntitySets.expenseReports), headers: var_headers, options: var_options).entityList())
    }

    open func fetchExpenseReports(matching query: DataQuery = DataQuery(), headers: HTTPHeaders? = nil, options: RequestOptions? = nil, completionHandler: @escaping (Array<ExpenseReportItem>?, Error?) -> Void) {
        self.addBackgroundOperationForFunction {
            do {
                let result: Array<ExpenseReportItem> = try self.fetchExpenseReports(matching: query, headers: headers, options: options)
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

    open func fetchExpenses(matching query: DataQuery? = nil, headers: HTTPHeaders? = nil, options: RequestOptions? = nil) throws -> Array<Expense> {
        let var_query: DataQuery = DataQuery.newIfNull(query: query)
        let var_headers: HTTPHeaders = HTTPHeaders.emptyIfNull(headers: headers)
        let var_options: RequestOptions = try RequestOptions.noneIfNull(options: options)
        return try Expense.array(from: self.executeQuery(var_query.fromDefault(TravelexpenseMetadata.EntitySets.expenses), headers: var_headers, options: var_options).entityList())
    }

    open func fetchExpenses(matching query: DataQuery = DataQuery(), headers: HTTPHeaders? = nil, options: RequestOptions? = nil, completionHandler: @escaping (Array<Expense>?, Error?) -> Void) {
        self.addBackgroundOperationForFunction {
            do {
                let result: Array<Expense> = try self.fetchExpenses(matching: query, headers: headers, options: options)
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

    open func fetchPayment(matching query: DataQuery, headers: HTTPHeaders? = nil, options: RequestOptions? = nil) throws -> Payment {
        let var_headers: HTTPHeaders = HTTPHeaders.emptyIfNull(headers: headers)
        let var_options: RequestOptions = try RequestOptions.noneIfNull(options: options)
        return try CastRequired<Payment>.from(self.executeQuery(query.fromDefault(TravelexpenseMetadata.EntitySets.payments), headers: var_headers, options: var_options).requiredEntity())
    }

    open func fetchPayment(matching query: DataQuery, headers: HTTPHeaders? = nil, options: RequestOptions? = nil, completionHandler: @escaping (Payment?, Error?) -> Void) {
        self.addBackgroundOperationForFunction {
            do {
                let result: Payment = try self.fetchPayment(matching: query, headers: headers, options: options)
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

    open func fetchPayments(matching query: DataQuery? = nil, headers: HTTPHeaders? = nil, options: RequestOptions? = nil) throws -> Array<Payment> {
        let var_query: DataQuery = DataQuery.newIfNull(query: query)
        let var_headers: HTTPHeaders = HTTPHeaders.emptyIfNull(headers: headers)
        let var_options: RequestOptions = try RequestOptions.noneIfNull(options: options)
        return try Payment.array(from: self.executeQuery(var_query.fromDefault(TravelexpenseMetadata.EntitySets.payments), headers: var_headers, options: var_options).entityList())
    }

    open func fetchPayments(matching query: DataQuery = DataQuery(), headers: HTTPHeaders? = nil, options: RequestOptions? = nil, completionHandler: @escaping (Array<Payment>?, Error?) -> Void) {
        self.addBackgroundOperationForFunction {
            do {
                let result: Array<Payment> = try self.fetchPayments(matching: query, headers: headers, options: options)
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

    open func fetchReportStati(matching query: DataQuery? = nil, headers: HTTPHeaders? = nil, options: RequestOptions? = nil) throws -> Array<ReportStatus> {
        let var_query: DataQuery = DataQuery.newIfNull(query: query)
        let var_headers: HTTPHeaders = HTTPHeaders.emptyIfNull(headers: headers)
        let var_options: RequestOptions = try RequestOptions.noneIfNull(options: options)
        return try ReportStatus.array(from: self.executeQuery(var_query.fromDefault(TravelexpenseMetadata.EntitySets.reportStati), headers: var_headers, options: var_options).entityList())
    }

    open func fetchReportStati(matching query: DataQuery = DataQuery(), headers: HTTPHeaders? = nil, options: RequestOptions? = nil, completionHandler: @escaping (Array<ReportStatus>?, Error?) -> Void) {
        self.addBackgroundOperationForFunction {
            do {
                let result: Array<ReportStatus> = try self.fetchReportStati(matching: query, headers: headers, options: options)
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

    open func fetchReportStatus(matching query: DataQuery, headers: HTTPHeaders? = nil, options: RequestOptions? = nil) throws -> ReportStatus {
        let var_headers: HTTPHeaders = HTTPHeaders.emptyIfNull(headers: headers)
        let var_options: RequestOptions = try RequestOptions.noneIfNull(options: options)
        return try CastRequired<ReportStatus>.from(self.executeQuery(query.fromDefault(TravelexpenseMetadata.EntitySets.reportStati), headers: var_headers, options: var_options).requiredEntity())
    }

    open func fetchReportStatus(matching query: DataQuery, headers: HTTPHeaders? = nil, options: RequestOptions? = nil, completionHandler: @escaping (ReportStatus?, Error?) -> Void) {
        self.addBackgroundOperationForFunction {
            do {
                let result: ReportStatus = try self.fetchReportStatus(matching: query, headers: headers, options: options)
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

    open func fetchReservation(matching query: DataQuery, headers: HTTPHeaders? = nil, options: RequestOptions? = nil) throws -> Reservation {
        let var_headers: HTTPHeaders = HTTPHeaders.emptyIfNull(headers: headers)
        let var_options: RequestOptions = try RequestOptions.noneIfNull(options: options)
        return try CastRequired<Reservation>.from(self.executeQuery(query.fromDefault(TravelexpenseMetadata.EntitySets.reservations), headers: var_headers, options: var_options).requiredEntity())
    }

    open func fetchReservation(matching query: DataQuery, headers: HTTPHeaders? = nil, options: RequestOptions? = nil, completionHandler: @escaping (Reservation?, Error?) -> Void) {
        self.addBackgroundOperationForFunction {
            do {
                let result: Reservation = try self.fetchReservation(matching: query, headers: headers, options: options)
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

    open func fetchReservationItem(matching query: DataQuery, headers: HTTPHeaders? = nil, options: RequestOptions? = nil) throws -> ReservationItem {
        let var_headers: HTTPHeaders = HTTPHeaders.emptyIfNull(headers: headers)
        let var_options: RequestOptions = try RequestOptions.noneIfNull(options: options)
        return try CastRequired<ReservationItem>.from(self.executeQuery(query.fromDefault(TravelexpenseMetadata.EntitySets.reservationItems), headers: var_headers, options: var_options).requiredEntity())
    }

    open func fetchReservationItem(matching query: DataQuery, headers: HTTPHeaders? = nil, options: RequestOptions? = nil, completionHandler: @escaping (ReservationItem?, Error?) -> Void) {
        self.addBackgroundOperationForFunction {
            do {
                let result: ReservationItem = try self.fetchReservationItem(matching: query, headers: headers, options: options)
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

    open func fetchReservationItems(matching query: DataQuery? = nil, headers: HTTPHeaders? = nil, options: RequestOptions? = nil) throws -> Array<ReservationItem> {
        let var_query: DataQuery = DataQuery.newIfNull(query: query)
        let var_headers: HTTPHeaders = HTTPHeaders.emptyIfNull(headers: headers)
        let var_options: RequestOptions = try RequestOptions.noneIfNull(options: options)
        return try ReservationItem.array(from: self.executeQuery(var_query.fromDefault(TravelexpenseMetadata.EntitySets.reservationItems), headers: var_headers, options: var_options).entityList())
    }

    open func fetchReservationItems(matching query: DataQuery = DataQuery(), headers: HTTPHeaders? = nil, options: RequestOptions? = nil, completionHandler: @escaping (Array<ReservationItem>?, Error?) -> Void) {
        self.addBackgroundOperationForFunction {
            do {
                let result: Array<ReservationItem> = try self.fetchReservationItems(matching: query, headers: headers, options: options)
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

    open func fetchReservations(matching query: DataQuery? = nil, headers: HTTPHeaders? = nil, options: RequestOptions? = nil) throws -> Array<Reservation> {
        let var_query: DataQuery = DataQuery.newIfNull(query: query)
        let var_headers: HTTPHeaders = HTTPHeaders.emptyIfNull(headers: headers)
        let var_options: RequestOptions = try RequestOptions.noneIfNull(options: options)
        return try Reservation.array(from: self.executeQuery(var_query.fromDefault(TravelexpenseMetadata.EntitySets.reservations), headers: var_headers, options: var_options).entityList())
    }

    open func fetchReservations(matching query: DataQuery = DataQuery(), headers: HTTPHeaders? = nil, options: RequestOptions? = nil, completionHandler: @escaping (Array<Reservation>?, Error?) -> Void) {
        self.addBackgroundOperationForFunction {
            do {
                let result: Array<Reservation> = try self.fetchReservations(matching: query, headers: headers, options: options)
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

    open func fetchTripItem(matching query: DataQuery, headers: HTTPHeaders? = nil, options: RequestOptions? = nil) throws -> TripItem {
        let var_headers: HTTPHeaders = HTTPHeaders.emptyIfNull(headers: headers)
        let var_options: RequestOptions = try RequestOptions.noneIfNull(options: options)
        return try CastRequired<TripItem>.from(self.executeQuery(query.fromDefault(TravelexpenseMetadata.EntitySets.tripItems), headers: var_headers, options: var_options).requiredEntity())
    }

    open func fetchTripItem(matching query: DataQuery, headers: HTTPHeaders? = nil, options: RequestOptions? = nil, completionHandler: @escaping (TripItem?, Error?) -> Void) {
        self.addBackgroundOperationForFunction {
            do {
                let result: TripItem = try self.fetchTripItem(matching: query, headers: headers, options: options)
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

    open func fetchTripItems(matching query: DataQuery? = nil, headers: HTTPHeaders? = nil, options: RequestOptions? = nil) throws -> Array<TripItem> {
        let var_query: DataQuery = DataQuery.newIfNull(query: query)
        let var_headers: HTTPHeaders = HTTPHeaders.emptyIfNull(headers: headers)
        let var_options: RequestOptions = try RequestOptions.noneIfNull(options: options)
        return try TripItem.array(from: self.executeQuery(var_query.fromDefault(TravelexpenseMetadata.EntitySets.tripItems), headers: var_headers, options: var_options).entityList())
    }

    open func fetchTripItems(matching query: DataQuery = DataQuery(), headers: HTTPHeaders? = nil, options: RequestOptions? = nil, completionHandler: @escaping (Array<TripItem>?, Error?) -> Void) {
        self.addBackgroundOperationForFunction {
            do {
                let result: Array<TripItem> = try self.fetchTripItems(matching: query, headers: headers, options: options)
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

    @available(swift, deprecated: 4.0, renamed: "fetchPayments")
    open func payments(query: DataQuery = DataQuery()) throws -> Array<Payment> {
        return try self.fetchPayments(matching: query)
    }

    @available(swift, deprecated: 4.0, renamed: "fetchPayments")
    open func payments(query: DataQuery = DataQuery(), completionHandler: @escaping (Array<Payment>?, Error?) -> Void) {
        self.fetchPayments(matching: query, headers: nil, options: nil, completionHandler: completionHandler)
    }

    open override func refreshMetadata() throws {
        objc_sync_enter(self)
        defer { objc_sync_exit(self) }
        do {
            try ProxyInternal.refreshMetadata(service: self, fetcher: nil, options: TravelexpenseMetadataParser.options)
            TravelexpenseMetadataChanges.merge(metadata: self.metadata)
        }
    }

    @available(swift, deprecated: 4.0, renamed: "fetchReportStati")
    open func reportStati(query: DataQuery = DataQuery()) throws -> Array<ReportStatus> {
        return try self.fetchReportStati(matching: query)
    }

    @available(swift, deprecated: 4.0, renamed: "fetchReportStati")
    open func reportStati(query: DataQuery = DataQuery(), completionHandler: @escaping (Array<ReportStatus>?, Error?) -> Void) {
        self.fetchReportStati(matching: query, headers: nil, options: nil, completionHandler: completionHandler)
    }

    @available(swift, deprecated: 4.0, renamed: "fetchReservationItems")
    open func reservationItems(query: DataQuery = DataQuery()) throws -> Array<ReservationItem> {
        return try self.fetchReservationItems(matching: query)
    }

    @available(swift, deprecated: 4.0, renamed: "fetchReservationItems")
    open func reservationItems(query: DataQuery = DataQuery(), completionHandler: @escaping (Array<ReservationItem>?, Error?) -> Void) {
        self.fetchReservationItems(matching: query, headers: nil, options: nil, completionHandler: completionHandler)
    }

    @available(swift, deprecated: 4.0, renamed: "fetchReservations")
    open func reservations(query: DataQuery = DataQuery()) throws -> Array<Reservation> {
        return try self.fetchReservations(matching: query)
    }

    @available(swift, deprecated: 4.0, renamed: "fetchReservations")
    open func reservations(query: DataQuery = DataQuery(), completionHandler: @escaping (Array<Reservation>?, Error?) -> Void) {
        self.fetchReservations(matching: query, headers: nil, options: nil, completionHandler: completionHandler)
    }

    @available(swift, deprecated: 4.0, renamed: "fetchTripItems")
    open func tripItems(query: DataQuery = DataQuery()) throws -> Array<TripItem> {
        return try self.fetchTripItems(matching: query)
    }

    @available(swift, deprecated: 4.0, renamed: "fetchTripItems")
    open func tripItems(query: DataQuery = DataQuery(), completionHandler: @escaping (Array<TripItem>?, Error?) -> Void) {
        self.fetchTripItems(matching: query, headers: nil, options: nil, completionHandler: completionHandler)
    }
}
