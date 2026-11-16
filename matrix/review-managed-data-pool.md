# S58 single implementation review: managed data / pool borrowing ABI

Reviewed only the canonical `_managed_native.py` change from `29f64b9c`, now published as the WIP `b1dccf8319afc63aab65d33166115b48e88eb0b3`: explicit borrowed `data` beside the sole owning MemInfo; initialization by unbox/adopt; data use by boxing and borrowed access; and `pool_item` sharing an existing immutable tuple owner's MemInfo while incrementing its NRT reference. Visitor/function/cell/language changes and tests, harnesses, reports and evidence were outside this review.

No concrete wrong result, crash, or retained owner leak was found in the scoped changes. Small serial below-normal ABI-only native probes used compiled entry points directly. Nested tuple selection returned the exact selected Python object; selection remained valid after replacing the temporary parent tuple; 100 repeated successful selections and 100 post-selection IndexError paths left both the selected object's and root tuple's reference counts unchanged (3 to 3 and 2 to 2); and a selected object participating in a tuple/object cycle was collected after all external results were dropped.

All managed constructors in this module initialize the new data field. A successful pool selection increments the one shared owner and records the actual selected pointer; failed selection returns a null owner/pointer pair without taking an extra owner reference. Boxing increments the selected Python object before releasing the shared native owner.

This completes the single scoped implementation review. No implementation files were changed and no re-review is requested. Full acceptance remains the owning run's decision after its required checks.
