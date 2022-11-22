// MVVMDataSourceState

/// Every Data Source will manage and report this state
public enum MVVMD_DataSourceState {
    /// No OS resources are allocated for the data source.
    case uninitialized
    /// Data source is connecting to OS-system resources.
    /// If not available, data source will enter error state
    case initializing
    /// OS-system resources are allocated, but no OS-domain resources are allocated
    /// Data source may not have secured OS or Server permissions and needs to authorize.
    case unauthorized
    /// Data source has authorization. OS-system resources are allocated.
    /// OS-domain resources may be allocated
    case available
    /// Data Source is initialized but is unavailable.
    /// This could be the device is in Airplane mode, etc.
    case unavailable
    /// Data source is initialzed, but  data streaming is suspended due to
    /// external condition: App is backgrounded, etc.
    case suspended
    /// Unrecoverable Error has occurred
    /// OS-system or -domain resources may be allocated.
    case error(Error)
}
