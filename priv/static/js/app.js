/******/ (function(modules) { // webpackBootstrap
/******/ 	// The module cache
/******/ 	var installedModules = {};
/******/
/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {
/******/
/******/ 		// Check if module is in cache
/******/ 		if(installedModules[moduleId]) {
/******/ 			return installedModules[moduleId].exports;
/******/ 		}
/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = installedModules[moduleId] = {
/******/ 			i: moduleId,
/******/ 			l: false,
/******/ 			exports: {}
/******/ 		};
/******/
/******/ 		// Execute the module function
/******/ 		modules[moduleId].call(module.exports, module, module.exports, __webpack_require__);
/******/
/******/ 		// Flag the module as loaded
/******/ 		module.l = true;
/******/
/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}
/******/
/******/
/******/ 	// expose the modules object (__webpack_modules__)
/******/ 	__webpack_require__.m = modules;
/******/
/******/ 	// expose the module cache
/******/ 	__webpack_require__.c = installedModules;
/******/
/******/ 	// define getter function for harmony exports
/******/ 	__webpack_require__.d = function(exports, name, getter) {
/******/ 		if(!__webpack_require__.o(exports, name)) {
/******/ 			Object.defineProperty(exports, name, { enumerable: true, get: getter });
/******/ 		}
/******/ 	};
/******/
/******/ 	// define __esModule on exports
/******/ 	__webpack_require__.r = function(exports) {
/******/ 		if(typeof Symbol !== 'undefined' && Symbol.toStringTag) {
/******/ 			Object.defineProperty(exports, Symbol.toStringTag, { value: 'Module' });
/******/ 		}
/******/ 		Object.defineProperty(exports, '__esModule', { value: true });
/******/ 	};
/******/
/******/ 	// create a fake namespace object
/******/ 	// mode & 1: value is a module id, require it
/******/ 	// mode & 2: merge all properties of value into the ns
/******/ 	// mode & 4: return value when already ns object
/******/ 	// mode & 8|1: behave like require
/******/ 	__webpack_require__.t = function(value, mode) {
/******/ 		if(mode & 1) value = __webpack_require__(value);
/******/ 		if(mode & 8) return value;
/******/ 		if((mode & 4) && typeof value === 'object' && value && value.__esModule) return value;
/******/ 		var ns = Object.create(null);
/******/ 		__webpack_require__.r(ns);
/******/ 		Object.defineProperty(ns, 'default', { enumerable: true, value: value });
/******/ 		if(mode & 2 && typeof value != 'string') for(var key in value) __webpack_require__.d(ns, key, function(key) { return value[key]; }.bind(null, key));
/******/ 		return ns;
/******/ 	};
/******/
/******/ 	// getDefaultExport function for compatibility with non-harmony modules
/******/ 	__webpack_require__.n = function(module) {
/******/ 		var getter = module && module.__esModule ?
/******/ 			function getDefault() { return module['default']; } :
/******/ 			function getModuleExports() { return module; };
/******/ 		__webpack_require__.d(getter, 'a', getter);
/******/ 		return getter;
/******/ 	};
/******/
/******/ 	// Object.prototype.hasOwnProperty.call
/******/ 	__webpack_require__.o = function(object, property) { return Object.prototype.hasOwnProperty.call(object, property); };
/******/
/******/ 	// __webpack_public_path__
/******/ 	__webpack_require__.p = "./../js/";
/******/
/******/
/******/ 	// Load entry module and return exports
/******/ 	return __webpack_require__(__webpack_require__.s = 0);
/******/ })
/************************************************************************/
/******/ ({

/***/ "./js/app.js":
/*!*******************!*\
  !*** ./js/app.js ***!
  \*******************/
/*! no exports provided */
/***/ (function(module, exports) {

eval("throw new Error(\"Module build failed (from ./node_modules/babel-loader/lib/index.js):\\nError: [BABEL] /app/assets/js/app.js: Unknown option: .targets. Check out https://babeljs.io/docs/en/babel-core/#options for more information about options.\\n- Maybe you meant to use\\n\\\"preset\\\": [\\n  [\\\"@babel/preset-env\\\", {\\n  \\\"targets\\\": {\\n    \\\"node\\\": \\\"current\\\"\\n  }\\n}]\\n]\\nTo be a valid preset, its name and options should be wrapped in a pair of brackets\\n    at throwUnknownError (/app/assets/node_modules/@babel/core/lib/config/validation/options.js:124:27)\\n    at Object.keys.forEach.key (/app/assets/node_modules/@babel/core/lib/config/validation/options.js:109:5)\\n    at Array.forEach (<anonymous>)\\n    at validateNested (/app/assets/node_modules/@babel/core/lib/config/validation/options.js:85:21)\\n    at validate (/app/assets/node_modules/@babel/core/lib/config/validation/options.js:76:10)\\n    at instantiatePreset (/app/assets/node_modules/@babel/core/lib/config/full.js:303:36)\\n    at cachedFunction (/app/assets/node_modules/@babel/core/lib/config/caching.js:62:27)\\n    at cachedFunction.next (<anonymous>)\\n    at evaluateSync (/app/assets/node_modules/gensync/index.js:244:28)\\n    at sync (/app/assets/node_modules/gensync/index.js:84:14)\\n    at loadPresetDescriptor (/app/assets/node_modules/@babel/core/lib/config/full.js:292:18)\\n    at loadPresetDescriptor.next (<anonymous>)\\n    at recurseDescriptors (/app/assets/node_modules/@babel/core/lib/config/full.js:107:30)\\n    at recurseDescriptors.next (<anonymous>)\\n    at loadFullConfig (/app/assets/node_modules/@babel/core/lib/config/full.js:142:6)\\n    at loadFullConfig.next (<anonymous>)\\n    at Function.transform (/app/assets/node_modules/@babel/core/lib/transform.js:25:45)\\n    at transform.next (<anonymous>)\\n    at step (/app/assets/node_modules/gensync/index.js:254:32)\\n    at gen.next (/app/assets/node_modules/gensync/index.js:266:13)\\n    at async.call.value (/app/assets/node_modules/gensync/index.js:216:11)\");//# sourceURL=[module]\n//# sourceMappingURL=data:application/json;charset=utf-8;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoiLi9qcy9hcHAuanMuanMiLCJzb3VyY2VzIjpbXSwibWFwcGluZ3MiOiIiLCJzb3VyY2VSb290IjoiIn0=\n//# sourceURL=webpack-internal:///./js/app.js\n");

/***/ }),

/***/ 0:
/*!*************************!*\
  !*** multi ./js/app.js ***!
  \*************************/
/*! no static exports found */
/***/ (function(module, exports, __webpack_require__) {

module.exports = __webpack_require__(/*! ./js/app.js */"./js/app.js");


/***/ })

/******/ });