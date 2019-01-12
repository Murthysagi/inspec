# This unit test performs some tests to verify that
# the inspec-resource-lister plugin is configured correctly.

# Include our test harness
require_relative '../helper'

# Load the class under test, the Plugin definition.
require 'inspec-core-attributes/plugin'

# Because InSpec is a Spec-style test suite, we're going to use MiniTest::Spec
# here, for familiar look and feel. However, this isn't InSpec (or RSpec) code.

describe InspecPlugins::CoreAttributes::Plugin do

  # When writing tests, you can use `let` to create variables that you
  # can reference easily.

  # Internally, plugins are always known by a Symbol name. Convert here.
  let(:plugin_name) { :'inspec-core-attributes' }

  # The Registry knows about all plugins that ship with InSpec by
  # default, as well as any that are installed by the user. When a
  # plugin definition is loaded, it will also self-register.
  let(:registry) { Inspec::Plugin::V2::Registry.instance }

  # The plugin status record tells us what the Registry knows.
  # Note that you can use previously-defined 'let's.
  let(:status) { registry[plugin_name] }

  # OK, actual tests!

  # Does the Registry know about us at all?
  it "should be registered" do
    registry.known_plugin?(plugin_name)
  end

  # Some tests through here use minitest Expectations, which attach to all
  # Objects, and begin with 'must' (positive) or 'wont' (negative)
  # See https://ruby-doc.org/stdlib-2.1.0/libdoc/minitest/rdoc/MiniTest/Expectations.html

  # The plugin system had an undocumented v1 API; this should be a v2 example.
  it "should be an api-v2 plugin" do
    status.api_generation.must_equal(2)
  end

  # Plugins can support several different activator hooks, each of which has a type.
  it "should include a attribute_provider activator hook" do
    status.plugin_types.must_include(:attribute_provider)
  end
end