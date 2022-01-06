local file = getmetatable(io.stdout)

return {
  [assert] = [=[v [, message]]=],
  [collectgarbage] = [=[[opt [, arg]]]=],
  [dofile] = [=[[filename]]=],
  [getfenv] = [=[[f]]=],
  [getmetatable] = [=[object]=],
  [ipairs] = [=[t]=],
  [load] = [=[func [, chunkname]]=],
  [loadfile] = [=[[filename]]=],
  [loadstring] = [=[string [, chunkname]]=],
  [next] = [=[table [, index]]=],
  [pairs] = [=[t]=],
  [pcall] = [=[f, arg1, ...]=],
  [print] = [=[...]=],
  [rawequal] = [=[v1, v2]=],
  [rawget] = [=[table, index]=],
  [rawset] = [=[table, index, value]=],
  [select] = [=[index, ...]=],
  [setfenv] = [=[f, table]=],
  [setmetatable] = [=[table, metatable]=],
  [tonumber] = [=[e [, base]]=],
  [tostring] = [=[e]=],
  [type] = [=[v]=],
  [unpack] = [=[list [, i [, j]]]=],
  [xpcall] = [=[f, err]=],
  [coroutine.create] = [=[f]=],
  [coroutine.resume] = [=[co [, val1, ...]]=],
  [coroutine.running] = [=[]=],
  [coroutine.status] = [=[co]=],
  [coroutine.wrap] = [=[f]=],
  [coroutine.yield] = [=[...]=],
  [module] = [=[name [, ...]]=],
  [require] = [=[modname]=],
  [package.loadlib] = [=[libname, funcname]=],
  [package.seeall] = [=[module]=],
  [string.byte] = [=[s [, i [, j]]]=],
  [string.char] = [=[...]=],
  [string.dump] = [=[function]=],
  [string.find] = [=[s, pattern [, init [, plain]]]=],
  [string.format] = [=[formatstring, ...]=],
  [string.gmatch] = [=[s, pattern]=],
  [string.gsub] = [=[s, pattern, repl [, n]]=],
  [string.len] = [=[s]=],
  [string.lower] = [=[s]=],
  [string.match] = [=[s, pattern [, init]]=],
  [string.rep] = [=[s, n]=],
  [string.reverse] = [=[s]=],
  [string.sub] = [=[s, i [, j]]=],
  [string.upper] = [=[s]=],
  [table.concat] = [=[table [, sep [, i [, j]]]]=],
  [table.insert] = [=[table, [pos,] value]=],
  [table.maxn] = [=[table]=],
  [table.remove] = [=[table [, pos]]=],
  [table.sort] = [=[table [, comp]]=],
  [math.abs] = [=[x]=],
  [math.acos] = [=[x]=],
  [math.asin] = [=[x]=],
  [math.atan] = [=[x]=],
  [math.atan2] = [=[y, x]=],
  [math.ceil] = [=[x]=],
  [math.cos] = [=[x]=],
  [math.cosh] = [=[x]=],
  [math.deg] = [=[x]=],
  [math.exp] = [=[x]=],
  [math.floor] = [=[x]=],
  [math.fmod] = [=[x, y]=],
  [math.frexp] = [=[x]=],
  [math.ldexp] = [=[m, e]=],
  [math.log] = [=[x]=],
  [math.log10] = [=[x]=],
  [math.max] = [=[x, ...]=],
  [math.min] = [=[x, ...]=],
  [math.modf] = [=[x]=],
  [math.pow] = [=[x, y]=],
  [math.rad] = [=[x]=],
  [math.random] = [=[[m [, n]]]=],
  [math.randomseed] = [=[x]=],
  [math.sin] = [=[x]=],
  [math.sinh] = [=[x]=],
  [math.sqrt] = [=[x]=],
  [math.tan] = [=[x]=],
  [math.tanh] = [=[x]=],
  [io.close] = [=[[file]]=],
  [io.flush] = [=[]=],
  [io.input] = [=[[file]]=],
  [io.lines] = [=[[filename]]=],
  [io.open] = [=[filename [, mode]]=],
  [io.output] = [=[[file]]=],
  [io.popen] = [=[prog [, mode]]=],
  [io.read] = [=[...]=],
  [io.tmpfile] = [=[]=],
  [io.type] = [=[obj]=],
  [io.write] = [=[...]=],
  [file.close] = [=[]=],
  [file.flush] = [=[]=],
  [file.lines] = [=[]=],
  [file.read] = [=[...]=],
  [file.seek] = [=[[whence] [, offset]]=],
  [file.setvbuf] = [=[mode [, size]]=],
  [file.write] = [=[...]=],
  [os.clock] = [=[]=],
  [os.date] = [=[[format [, time]]]=],
  [os.difftime] = [=[t2, t1]=],
  [os.execute] = [=[[command]]=],
  [os.exit] = [=[[code]]=],
  [os.getenv] = [=[varname]=],
  [os.remove] = [=[filename]=],
  [os.rename] = [=[oldname, newname]=],
  [os.setlocale] = [=[locale [, category]]=],
  [os.time] = [=[[table]]=],
  [os.tmpname] = [=[]=],
  [debug.debug] = [=[]=],
  [debug.getfenv] = [=[o]=],
  [debug.gethook] = [=[[thread]]=],
  [debug.getinfo] = [=[[thread,] function [, what]]=],
  [debug.getlocal] = [=[[thread,] level, local]=],
  [debug.getmetatable] = [=[object]=],
  [debug.getregistry] = [=[]=],
  [debug.getupvalue] = [=[func, up]=],
  [debug.setfenv] = [=[object, table]=],
  [debug.sethook] = [=[[thread,] hook, mask [, count]]=],
  [debug.setlocal] = [=[[thread,] level, local, value]=],
  [debug.setmetatable] = [=[object, table]=],
  [debug.setupvalue] = [=[func, up, value]=],
  [debug.traceback] = [=[[thread,] [message [, level]]]=],
}
