#!/bin/bash

BASE_DIR=$(cd $(dirname $0); pwd)/..

PKG_NAME=$1

PKG_DIR=$BASE_DIR/packages/$PKG_NAME
VERSION=$(cat $BASE_DIR/lerna.json | jq -r .version)

mkdir -p $PKG_DIR
mkdir -p $PKG_DIR/src

cat << JSON > $PKG_DIR/package.json
{
  "name": "$PKG_NAME",
  "version": "$VERSION",
  "description": "",
  "main": "lib/index.js",
  "scripts": {
    "prepublish": "tsc -p src/tsconfig.build.json"
  },
  "keywords": [
    "reg"
  ],
  "author": {
    "name": "Quramy",
    "email": "yosuke.kurami@gmail.com"
  },
  "repository": "git+https://github.com/Quramy/reg-suit.git",
  "license": "MIT",
  "devDependencies": {
    "typescript": "^2.3.4"
  },
  "dependencies": {
  }
}
JSON

cat << JSON > $PKG_DIR/src/tsconfig.build.json
{
  "extends": "../../../tsconfig.json",
  "compilerOptions": {
    "rootDir": ".",
    "outDir": "../lib"
  }
}
JSON

cat << JSON > $PKG_DIR/src/tsconfig.json
{
  "extends": "./tsconfig.build.json",
  "compilerOptions": {
  }
}
JSON

cat << TYPESCRIPT > $PKG_DIR/src/index.ts
console.log("hello, $PKG_NAME");
TYPESCRIPT

cat << MARKDOWN > $PKG_DIR/README.md
# $PKG_NAME

*T.B.D.*
MARKDOWN

cat << IGNORE > $PKG_DIR/.gitignore
node_modules/
lib/
IGNORE

cat << IGNORE > $PKG_DIR/.npmignore
yarn.lock
lib/**/*.test.js
lib/**/*.spec.js
lib/**/*.test.d.ts
lib/**/*.spec.d.ts
src/
test/
e2e/
built_e2e/
built/
IGNORE
