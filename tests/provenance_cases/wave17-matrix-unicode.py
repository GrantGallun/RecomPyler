"""wave17 CHECKPOINT44 and earlier owner review cases; identity is nonnumeric."""

GLOBAL_TEXT='wide λ global owner'

def for_target_store(text,values):
    """Return last selected iterable item or initializer; numeric leaves S49-exempt."""
    count=0
    for count in values:
        if text.isupper():count+=1
    return count,text

def for_else_owner(text,other):
    """Break skips else; result selects text by exact identity."""
    selected=text
    for _ in range(1):break
    else:selected=other
    return selected,text

def while_else_owner(text,other):
    """Break skips else; result selects text by exact identity."""
    selected=text
    while True:break
    else:selected=other
    return selected,text

def global_owner_rebinding(text):
    """Warm adapter must select current GLOBAL_TEXT after equal distinct rebind."""
    return GLOBAL_TEXT,text

def helper_import_callback(text):
    """Original performs no import; warmed adapter must introduce no import hook."""
    return text.isupper(),text

def active_observer_events(text):
    """Profile/trace/PEP669 must see original events; adapter delegates to Python."""
    return text.isupper(),text

def store_before_break(text,other):
    """Break selects other; unconditional else interpretation incorrectly returns text."""
    value=text
    for _ in range(1):
        value=other
        break
    else:value=text
    return value,text

def nested_tuple_alias(text):
    """Result children share one fresh tuple; tuple[0] IS original text."""
    value=(text,)
    return value,value

def original_code_tuple():
    """Result IS original co_consts tuple with exact member owners."""
    return ('wide λ constant',b'nonempty bytes constant')

def independent_characters(text):
    """Two non-Latin1 reads are distinct objects; equal data is no alias proof."""
    return text[0],text[0]

def shared_character(text):
    """Both returned children share the one selected character object."""
    char=text[0]
    return char,char
