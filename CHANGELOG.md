# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [3.0.4](https://github.com/astroband/ruby-xdr/compare/v3.0.3...v3.0.4) (2024-03-10)


### Bug Fixes

* update gemspec metadata ([8fc1ba5](https://github.com/astroband/ruby-xdr/commit/8fc1ba5126537116f8dc6017c4354b17d5285578))

### [3.0.3](https://github.com/astroband/ruby-xdr/compare/v3.0.2...v3.0.3) (2022-02-18)
### Bug Fixes
- make `XDR::Option` write empty strings as values ([#15](https://github.com/astroband/ruby-xdr/pull/15))


## [3.0.2](https://github.com/astroband/ruby-xdr/compare/v3.0.1...v3.0.2) - 2020-10-20
### Changed
- Relax lower bound for ActiveSupport dependency to support usage in Rails 4.2 ([#12](https://github.com/astroband/ruby-xdr/pull/12))

### Bug Fixes
- Fix non-bang arm accessors for XDR::Union ([#13](https://github.com/astroband/ruby-xdr/pull/13))
- Fix .from_xdr encoding param to accept symbols ([#14](https://github.com/astroband/ruby-xdr/pull/14))


## [3.0.1](https://github.com/astroband/ruby-xdr/compare/v3.0.0...v3.0.1) - 2020-06-10
### Added
- Add encoding parameter to Union#to_xdr ([#7](https://github.com/astroband/ruby-xdr/pull/7)).

### Bug Fixes
- Padding bytes are now properly validated when reading xdr values.  According to the XDR spec, padding must be zeros.


## [1.0.0](https://github.com/astroband/ruby-xdr/compare/v0.1.0...v1.0.0) - 2015-10-02
### Added
- the `to_xdr` helpers can take a second parameter that will encode the resulting output to hex or base64 when requested.
- the `from_xdr` helpers can take a second parameter that will trigger a decode from hex or base64 of the provided string before decoding from xdr.

### Changed
- `from_xdr` raises an ArgumentError when the input data is not fully consumed
