# Ideas Here

In order for these steps to happen correctly, we need to be able to architect projects from the ground up. So, then we can control what is supported and what is not currently supported.

## Constructing a project

User steps:
    1. Name of the project `name of the folder`
    2. Framework the project will use.
    3. Allow testing, or not.

Nativepack steps:
    1. create the project directory for the person to use.
    2. architect the project defaults for the framework the user chose.
        - React
            - Vite react app, then added, the nativepack.json.
                - run the vite scaffold from `pnpm`, `yarn`, `npm`.
                - remove the normal files inside the project, `prettier`.
    3. Add testing support to the project.
        - copy the required testing components ===> Convert Tests????


Take the node tree that React returns and convert that into swift.

-- Steps
```js
  // Make sure that nativepack can understand this.
  const Sidebar = () => {
    <div></div>;
  };
```

---->
```swift
var body: some View {
    Text("Some View")
}
```
