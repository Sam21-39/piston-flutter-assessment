1. **Key issues identified**
    - Large chunk of data passing via API. In terms, creates Pagination issues.
    - UI Side Pagination added but the previous data was removed from the list.

2. **Fixes implemented**
    - Code Folder Structure changed to match Clean-Architecture.
    - Bloc is introduced for state management.
    - Cache Added using Sqlite.
    - isolates used for heavy computing or transaction API call
    - Network Connectivity check Added

3. **Trade-offs and design decisions**
    - Routing Management was not added
    - List Pagination is not properly added
    - Transaction model updated for Cache management purposes