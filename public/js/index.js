MyModule().then((Module) => {
  const add = Module._add;
  const greeting = Module._greet;
  console.log("2 + 3 =", add(2, 3));
  console.log(greeting());
});
