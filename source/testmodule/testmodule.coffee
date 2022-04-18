############################################################
#region printLogFunctions
log = (arg) ->
    if allModules.debugmodule.modulesToDebug["testmodule"]?  then console.log "[testmodule]: " + arg
    return
ostr = (obj) -> JSON.stringify(obj, null, 4)
olog = (obj) -> log "\n" + ostr(obj)
print = (arg) -> console.log(arg)
#endregion

############################################################    
import * as state from "./statecachemodule"
import * as defaultState from "./defaultstate"

sampleData1 = {
    nodeId: "1deadbeefdeadbeefdeadbeefdeadbeefdeadbeefdeadbeefdeadbeefdeadbeef"
    secretKey: "1deadbeefdeadbeefdeadbeefdeadbeefdeadbeefdeadbeefdeadbeefdeadbeef"
    secretManagerURL:"https://localhost:6999/"   
}

sampleData2 = {
    nodeId:"2deadbeefdeadbeefdeadbeefdeadbeefdeadbeefdeadbeefdeadbeefdeadbeef"
    secretKey:"2deadbeefdeadbeefdeadbeefdeadbeefdeadbeefdeadbeefdeadbeefdeadbeef"
    secretManagerURL:"https://localhost:6999/"   
}

sampleData3 = {
    nodeId:"3deadbeefdeadbeefdeadbeefdeadbeefdeadbeefdeadbeefdeadbeefdeadbeef"
    secretKey:"3deadbeefdeadbeefdeadbeefdeadbeefdeadbeefdeadbeefdeadbeefdeadbeef"
    secretManagerURL:"https://localhost:6999/"   
}

sampleData4 = {
    nodeId:"4deadbeefdeadbeefdeadbeefdeadbeefdeadbeefdeadbeefdeadbeefdeadbeef"
    secretKey:"4deadbeefdeadbeefdeadbeefdeadbeefdeadbeefdeadbeefdeadbeefdeadbeef"
    secretManagerURL:"https://localhost:6999/"   
}

sampleData5 = {
    nodeId:"5deadbeefdeadbeefdeadbeefdeadbeefdeadbeefdeadbeefdeadbeefdeadbeef"
    secretKey:"5deadbeefdeadbeefdeadbeefdeadbeefdeadbeefdeadbeefdeadbeefdeadbeef"
    secretManagerURL:"https://localhost:6999/"   
}

############################################################    
export initialize = ->
    state.initialize({defaultState})
    return

############################################################    
export runTests = ->
    log "runTests"
    breakingCase()
    # state.logCacheState()

    state = state.load("state")
    olog state
    # state.logCacheState()

    # state.save("sample1", sampleData1)
    # # state.logCacheState()

    # state.save("sample2", sampleData2)
    # # state.logCacheState()

    # state.save("sample3", sampleData3)
    # # state.logCacheState()

    # state.save("sample4", sampleData4)
    # # state.logCacheState()

    # state.save("sample5", sampleData5)
    # # state.logCacheState()

    # state = state.load("state")
    # # state.logCacheState()


    # sample1 = state.load("sample1")
    # # state.logCacheState()




    # # sample2 = state.load("sample2")

    # sample3 = state.load("sample3") #this lines breaks it :-(

    # # sample4 = state.load("sample4")

    # sample5 = state.load("sample5")

    # sample3 = state.load("sample3")



    # state.remove("state")

    # state.remove("sample5")

    # state.remove("sample3")

    # state.remove("sample1")

    # state.remove("sample1")

    # sample2 = state.load("sample2")
    # # olog sample2
    # state.logCacheState()

    # sample3 = state.load("sample3")
    # olog sample3
    # state.logCacheState()

    # state.save("sample2", sampleData2)
    # state.load("sample1")
    # state.load("sample3")
    # state.load("sample4")
    # state.load("sample5")

    # state.remove("sample1")
    # state.remove("sample3")
    # state.remove("sample4")
    # state.remove("sample5")

    # state.logCacheState()
    # state.load("sample2")
    # state.logCacheState()


    return


breakingCase = ->

    state.save("sample1", sampleData1)

    state.save("sample2", sampleData2)

    state.save("sample3", sampleData3)

    state.save("sample4", sampleData4)

    state.save("sample5", sampleData5)

    state.load("state")

    state.load("sample1")




    state.load("sample3") #this lines breaks it :-(

    # state.load("sample4") #  this line repairs it

    # state.load("sample5") # this line does not matter
    # state.load("sample1") # this line does not matter
    # state.load("state") # this line does not matter
    # state.load("sample3") # this line does not matter

    state.remove("state")

    state.remove("sample5")

    state.remove("sample3")

    state.remove("sample1")

    # state.logCacheState()
    state.load("sample2")
    state.logCacheState()
