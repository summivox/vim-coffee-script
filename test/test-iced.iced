iced.catchExceptions()

await
  await setTimeout(defer(), 1000)
  for i in [0...100] by 1
    setTimeout(defer(), Math.random()*1000)

fun=(arg1, arg2, autocb)->
  return arg1+arg2
