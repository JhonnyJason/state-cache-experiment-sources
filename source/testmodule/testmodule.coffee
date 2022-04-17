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
import * as cache from "./statecachemodule"

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
export runTests = ->
    log "runTests"
    breakingCase()
    # cache.printCacheState()

    # state = cache.load("state")
    # # cache.printCacheState()

    # cache.save("sample1", sampleData1)
    # # cache.printCacheState()

    # cache.save("sample2", sampleData2)
    # # cache.printCacheState()

    # cache.save("sample3", sampleData3)
    # # cache.printCacheState()

    # cache.save("sample4", sampleData4)
    # # cache.printCacheState()

    # cache.save("sample5", sampleData5)
    # # cache.printCacheState()

    # state = cache.load("state")
    # # cache.printCacheState()


    # sample1 = cache.load("sample1")
    # # cache.printCacheState()




    # # sample2 = cache.load("sample2")

    # sample3 = cache.load("sample3") #this lines breaks it :-(

    # # sample4 = cache.load("sample4")

    # sample5 = cache.load("sample5")

    # sample3 = cache.load("sample3")



    # cache.remove("state")

    # cache.remove("sample5")

    # cache.remove("sample3")

    # cache.remove("sample1")

    # cache.remove("sample1")

    # sample2 = cache.load("sample2")
    # # olog sample2
    # cache.printCacheState()

    # sample3 = cache.load("sample3")
    # olog sample3
    # cache.printCacheState()

    # cache.save("sample2", sampleData2)
    # cache.load("sample1")
    # cache.load("sample3")
    # cache.load("sample4")
    # cache.load("sample5")

    # cache.remove("sample1")
    # cache.remove("sample3")
    # cache.remove("sample4")
    # cache.remove("sample5")

    # cache.printCacheState()
    # cache.load("sample2")
    # cache.printCacheState()


    return


breakingCase = ->

    cache.save("sample1", sampleData1)

    cache.save("sample2", sampleData2)

    cache.save("sample3", sampleData3)

    cache.save("sample4", sampleData4)

    cache.save("sample5", sampleData5)

    cache.load("state")

    cache.load("sample1")




    cache.load("sample3") #this lines breaks it :-(

    # cache.load("sample4") #  this line repairs it

    # cache.load("sample5") # this line does not matter
    # cache.load("sample1") # this line does not matter
    # cache.load("state") # this line does not matter
    # cache.load("sample3") # this line does not matter

    cache.remove("state")

    cache.remove("sample5")

    cache.remove("sample3")

    cache.remove("sample1")

    # cache.printCacheState()
    sample2 = cache.load("sample2")
    cache.printCacheState()
