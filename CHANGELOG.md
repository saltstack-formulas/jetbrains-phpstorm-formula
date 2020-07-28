# Changelog

## [1.0.2](https://github.com/saltstack-formulas/jetbrains-phpstorm-formula/compare/v1.0.1...v1.0.2) (2020-07-28)


### Bug Fixes

* **cmd.run:** wrap url in quotes (zsh) ([26c8676](https://github.com/saltstack-formulas/jetbrains-phpstorm-formula/commit/26c8676467bebaed2bccecf732c39ae5b2288591))
* **macos:** correct syntax ([433e071](https://github.com/saltstack-formulas/jetbrains-phpstorm-formula/commit/433e0710a43cfb9a20e8bcbb2ecb41e297fb002d))
* **macos:** do not create shortcut file ([88d78cc](https://github.com/saltstack-formulas/jetbrains-phpstorm-formula/commit/88d78ccb46102b66567a32230f6842a215c096f9))


### Code Refactoring

* **jetbrains:** align all jetbrains formulas ([0f19ddd](https://github.com/saltstack-formulas/jetbrains-phpstorm-formula/commit/0f19ddd554f730edbe64490a7380a65ea84344e7))


### Continuous Integration

* **kitchen:** use `saltimages` Docker Hub where available [skip ci] ([2e94039](https://github.com/saltstack-formulas/jetbrains-phpstorm-formula/commit/2e94039eb9005358c00600fde31d3658a11a68c8))


### Documentation

* **readme:** minor update ([72bcac5](https://github.com/saltstack-formulas/jetbrains-phpstorm-formula/commit/72bcac58b914f84a2db47e8fb66bca3ae8f14988))


### Styles

* **libtofs.jinja:** use Black-inspired Jinja formatting [skip ci] ([74cace2](https://github.com/saltstack-formulas/jetbrains-phpstorm-formula/commit/74cace286339538c75c5af1016fbe6823e30c516))

## [1.0.1](https://github.com/saltstack-formulas/jetbrains-phpstorm-formula/compare/v1.0.0...v1.0.1) (2020-06-15)


### Bug Fixes

* **edition:** better edition jinja code ([32835de](https://github.com/saltstack-formulas/jetbrains-phpstorm-formula/commit/32835de6caa5fd03cdc1aba36fe8acb0d94a4b61))


### Continuous Integration

* **kitchen+travis:** add new platforms [skip ci] ([43746a0](https://github.com/saltstack-formulas/jetbrains-phpstorm-formula/commit/43746a0ed4a1f4f3005946c3f8955fbd290254a9))
* **travis:** add notifications => zulip [skip ci] ([7bd839b](https://github.com/saltstack-formulas/jetbrains-phpstorm-formula/commit/7bd839b268399bf530547ef2da289f6204c9a2cc))


### Documentation

* **reamde:** updated formatting ([f7821d3](https://github.com/saltstack-formulas/jetbrains-phpstorm-formula/commit/f7821d37c2cbc1dee49ab3708545fad2e02b468a))

# 1.0.0 (2020-05-18)


### Continuous Integration

* **kitchen+travis:** adjust matrix to add `3000.3` ([83a6506](https://github.com/saltstack-formulas/jetbrains-phpstorm-formula/commit/83a65067e69aa20787fcb3c601702e9d112464f8))


### Documentation

* **readme:** add depth one ([07c0952](https://github.com/saltstack-formulas/jetbrains-phpstorm-formula/commit/07c0952758db9ba8d5d7a99390435b9ea3c657df))


### Features

* **formula:** align to template-formula; add ci ([09d2561](https://github.com/saltstack-formulas/jetbrains-phpstorm-formula/commit/09d25614f573fdc6c19fa0216fe81ff9bfb8ee0f))
* **formula:** align to template-formula; add ci ([aa268c8](https://github.com/saltstack-formulas/jetbrains-phpstorm-formula/commit/aa268c8327d6244d7ec5b78fa096341e2f6cd4bb))
* **semantic-release:** standardise for this formula ([32abf74](https://github.com/saltstack-formulas/jetbrains-phpstorm-formula/commit/32abf742baa228779ff76b3b6ca683aa2070df16))


### BREAKING CHANGES

* **formula:** Major refactor of formula to bring it in alignment with the
template-formula. As with all substantial changes, please ensure your
existing configurations work in the ways you expect from this formula.
