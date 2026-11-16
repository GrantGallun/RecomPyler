/* CPython GET_YIELD_FROM_ITER on the original frame's live stack word.
 * Creation, SEND and suspension remain with the original interpreter. */
static int generator_get_iter(_PyInterpreterFrame *frame, _PyStackRef *slot) {
    PyObject *source=PyStackRef_AsPyObjectBorrow(*slot);
    if (PyCoro_CheckExact(source)) {
        if (!(_PyFrame_GetCode(frame)->co_flags & (CO_COROUTINE|CO_ITERABLE_COROUTINE))) {
            PyErr_SetString(PyExc_TypeError,
                "cannot 'yield from' a coroutine object in a non-coroutine generator");
            return -1;
        }
    }
    else if (!PyGen_CheckExact(source)) {
        PyObject *iterator=PyObject_GetIter(source);
        if (!iterator)return -1;
        _PyStackRef previous=*slot;
        *slot=PyStackRef_FromPyObjectSteal(iterator);
        PyStackRef_CLOSE(previous);
    }
    return 0;
}
