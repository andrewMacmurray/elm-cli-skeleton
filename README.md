# Elm CLI Skeleton

Opinionated setup for an Elm CLI Program

## Build and run

1. Install the dependencies

```
npm install
```

2. Build the cli

```
npm run build
```

3. Rename your executable in package.json

From:

```json
  "bin": {
    "cli": "./bin/cli.js"
  },
```

To:

```json
  "bin": {
    "my-cli": "./bin/cli.js"
  },
```

3. Install it into your shell

```
npm link
```

4. Run the cli

```
my-cli --help
```
