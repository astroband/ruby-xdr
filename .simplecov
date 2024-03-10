require "simplecov_json_formatter"
require "simplecov-lcov"

SimpleCov::Formatter::LcovFormatter.config do |c|
  c.report_with_single_file = true
  c.single_report_path = "coverage/lcov.info"
end

SimpleCov.formatters = [
  SimpleCov::Formatter::LcovFormatter,
  SimpleCov::Formatter::JSONFormatter
]

SimpleCov.start do
  enable_coverage_for_eval if SimpleCov.coverage_for_eval_supported?
  enable_coverage(:branch)

  track_files "**/*.rb"

  add_filter "examples/"
end
