export name = "statecachemodule"
############################################################
#region printLogFunctions
log = (arg) ->
    if allModules.debugmodule.modulesToDebug["statecachemodule"]?  then console.log "[statecachemodule]: " + arg
    return
ostr = (obj) -> JSON.stringify(obj, null, 4)
olog = (obj) -> log "\n" + ostr(obj)
print = (arg) -> console.log(arg)
#endregion

import * as defaultState from "./defaultstate"
import * as store from "./statesavermodule"


############################################################
jsonCache = {}
objCache = {}

############################################################
#caching Stuff
cacheHeadEntry = null
cacheTailEntry = null
idToCacheEntry = {}
cacheSize = 0
maxCacheSize = 4
    
toJson = (obj) -> JSON.stringify(obj, null, 4)
############################################################
export save = (id, contentObj) ->
    log "save "+id
    if idToCacheEntry[id]? then idToCacheEntry[id].touch()
    else new CacheEntry(id)

    objCache[id] = contentObj
    contentJson = toJson(contentObj)
    if contentJson == jsonCache[id] then return
    else
        jsonCache[id] = contentJson
        await store.save(id, contentJson)
    return

export load = (id) ->
    log "load "+id
    if !objCache[id]? then loadCache(id)
    else idToCacheEntry[id].touch()
    return objCache[id]

export remove = (id) ->
    log "remove "+id
    entry = idToCacheEntry[id]
    return unless entry?
    entry.remove()
    await store.remove(id)
    return

export printCacheState = ->
    log "\n"
    if cacheHeadEntry?
        log "cacheHead Id: "+cacheHeadEntry.id
        cacheHeadEntry.print()

        entry = cacheHeadEntry.previousEntry
        while(entry?)
            entry.print()
            entry = entry.previousEntry
        log "cacheTail Id: "+cacheTailEntry.id
        log "\n"
    else olog { cacheHeadEntry, cacheTailEntry}
    olog {jsonCache}
    olog {cacheSize, maxCacheSize}

############################################################
loadCache = (id) ->
    log "loadCache"
    if !cacheHeadEntry? and !cacheTailEntry? then log "cache is empty!"
    new CacheEntry(id)

    if !cacheHeadEntry? or !cacheTailEntry? then log "cache has a problem!"

    { contentObj, contentJson } = store.load(id)

    if contentObj? 
        log "received contentObj"
        jsonCache[id] = contentJson
        objCache[id] = contentObj
    else loadDefault(id)
    return

loadDefault = (id) ->
    if !defaultState[id]?
        jsonCache[id] = "{}"
        objCache[id] = {}
    else
        jsonCache[id] = toJson(defaultState[id])
        objCache[id] = JSON.parse(jsonCache[id])
    return


############################################################
uncache = (id) ->
    delete objCache[id]
    delete jsonCache[id]
    delete idToCacheEntry[id]
    cacheSize--
    return

############################################################
cutCacheTail = ->
    tail = cacheTailEntry
    return unless tail?
    cacheTailEntry = tail.nextEntry
    if cacheTailEntry? then cacheTailEntry.previousEntry = null
    uncache(tail.id)
    return

############################################################
class CacheEntry
    constructor: (@id) ->
        log "constructor"
        olog {cacheSize, maxCacheSize}

        @nextEntry = null
        @previousEntry = cacheHeadEntry
        # log "cacheHeadEntry?"+cacheHeadEntry? 
        # log "cacheTailEntry?"+cacheTailEntry?

        if !cacheTailEntry? then cacheTailEntry = this
        # log "cacheHeadEntry?"+cacheHeadEntry? 
        # log "cacheTailEntry?"+cacheTailEntry?

        if cacheHeadEntry? then cacheHeadEntry.nextEntry = this
        cacheHeadEntry = this
        idToCacheEntry[@id] = this
        cacheSize++
        # log "cacheHeadEntry?"+cacheHeadEntry? 
        # log "cacheTailEntry?"+cacheTailEntry?
        olog {cacheSize, maxCacheSize}
        if cacheSize > maxCacheSize then cutCacheTail()
        olog {cacheSize, maxCacheSize}

    touch: ->
        return unless @nextEntry?# we are the head
        if @previousEntry? # we are in the middle
            @nextEntry.previousEntry = @previousEntry
            @previousEntry.nextEntry = @nextEntry
        else # we are the tail
            cacheTailEntry = @nextEntry
            @nextEntry.previousEntry = null
        @nextEntry = null
        @previousEntry = cacheHeadEntry
        if cacheHeadEntry? then cacheHeadEntry.nextEntry = this
        cacheHeadEntry = this
        return

    remove: ->
        if @nextEntry? and @previousEntry?
            @nextEntry.previousEntry = @previousEntry
            @previousEntry.nextEntry = @nextEntry
        if !@nextEntry? and !@previousEntry?
            cacheHeadEntry = null
            cacheTailEntry = null
        if @nextEntry? and !@previousEntry?
            @nextEntry.previousEntry = null
            cacheTailEntry = @nextEntry
        if !@nextEntry? and @previousEntry?
            @previousEntry.nextEntry = null
            cacheHeadEntry = @previousEntry
        uncache(@id)
    
    print: ->
        log @id
        if @nextEntry?
            log "  next: "+@nextEntry.id
        else
            log "  next: null"
        if @previousEntry?
            log "  previous: "+@previousEntry.id
        else
            log "  previous: null"

