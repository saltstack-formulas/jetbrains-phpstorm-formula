# Changelog

## [1.2.1](https://github.com/saltstack-formulas/jetbrains-phpstorm-formula/compare/v1.2.0...v1.2.1) (2020-12-16)


### Continuous Integration

* **gitlab-ci:** use GitLab CI as Travis CI replacement ([6029d65](https://github.com/saltstack-formulas/jetbrains-phpstorm-formula/commit/6029d656e9759a1503cf2f67a36f8c8f86352fa3))
* **pre-commit:** add to formula [skip ci] ([3fad186](https://github.com/saltstack-formulas/jetbrains-phpstorm-formula/commit/3fad186abc5d564ee34b0b8c240a273f2388c1ec))
* **pre-commit:** enable/disable `rstcheck` as relevant [skip ci] ([e09a3bf](https://github.com/saltstack-formulas/jetbrains-phpstorm-formula/commit/e09a3bf62555501bf08203cc23d6bdaf666e79c5))
* **pre-commit:** finalise `rstcheck` configuration [skip ci] ([c0b0723](https://github.com/saltstack-formulas/jetbrains-phpstorm-formula/commit/c0b0723c168558620ecb7f70934b4b2d00fd758e))


### Documentation

* **readme:** fix `rstcheck` violation [skip ci] ([1b421b0](https://github.com/saltstack-formulas/jetbrains-phpstorm-formula/commit/1b421b01993167eeb3710ef6dbf2a9e53f96cf8b)), closes [/travis-ci.org/github/myii/jetbrains-phpstorm-formula/builds/731607068#L259](https://github.com//travis-ci.org/github/myii/jetbrains-phpstorm-formula/builds/731607068/issues/L259)

# [1.2.0](https://github.com/saltstack-formulas/jetbrains-phpstorm-formula/compare/v1.1.0...v1.2.0) (2020-09-20)


### Features

* **clean:** add windows support ([4f72137](https://github.com/saltstack-formulas/jetbrains-phpstorm-formula/commit/4f72137679074ab46b1c60415990d09b3841bccd))

# [1.1.0](https://github.com/saltstack-formulas/jetbrains-phpstorm-formula/compare/v1.0.2...v1.1.0) (2020-09-20)


### Features

* **windows:** basic windows support ([74ee4f1](https://github.com/saltstack-formulas/jetbrains-phpstorm-formula/commit/74ee4f164912b680465987c0877907abeffb71c2))

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
