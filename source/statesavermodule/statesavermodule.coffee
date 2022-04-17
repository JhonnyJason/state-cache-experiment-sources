export name = "statesavermodule"
############################################################
#region printLogFunctions
log = (arg) ->
    if allModules.debugmodule.modulesToDebug["statesavermodule"]?  then console.log "[statesavermodule]: " + arg
    return
ostr = (obj) -> JSON.stringify(obj, null, 4)
olog = (obj) -> log "\n" + ostr(obj)
print = (arg) -> console.log(arg)
#endregion

############################################################
import pathModule from "path"
import fs from "fs"
import onChange from 'on-change'
############################################################
fsA = fs.promises

############################################################
relativeBasePath = "./state"
absoluteBasePath = null

############################################################
export initialize = ->
    log "initialize"
    absoluteBasePath = pathModule.resolve(process.cwd(), relativeBasePath)
    olog { absoluteBasePath } 
    fs.mkdirSync(absoluteBasePath) unless fs.existsSync(absoluteBasePath)
    return

############################################################
#region internalFunctions

getPath = (label) ->
    # log "getPath"
    filename = label+".json"
    path = pathModule.resolve(absoluteBasePath, filename)
    # log path
    return path

############################################################
#region backupFunctions
getBackupPath = (path) -> path+".backup"

backup = (path) ->
    backupPath = getBackupPath(path)
    try fs.copyFileSync(path, backupPath)
    catch err then log err.stack
    return

loadBackup = (id) ->
    log "loadBackup"
    path = getPath(id)
    backupPath = getBackupPath(path)
    try
        contentJson = fs.readFileSync(backupPath, "utf-8")
        contentObj = JSON.parse(contentJson)
        fsA.writeFile(path, contentJson)
        return { contentObj, contentJson }
    catch err 
        log err.message
        contentObj = null
        contentJson = null
        return {contentObj, contentJson}
    
#endregion

#endregion

############################################################
#region exposedFunctions
export load = (id) ->
    path = getPath(id)
    try
        contentJson = fs.readFileSync(path, "utf-8")
        contentObj = JSON.parse(contentJson)
        return { contentObj, contentJson }
    catch err
        log err.message
        return loadBackup(id)

export save = (id, contentJson) ->
    path = getPath(id)
    fs.writeFileSync(path, contentJson)
    backup(path)
    return

export remove = (id) ->
    path = getPath(id)
    backupPath = getBackupPath(path)
    p1 = fsA.unlink(path)
    p2 = fsA.unlink(backupPath)
    try await Promise.all([p1, p2])
    catch err then log err.message
    return

#endregion