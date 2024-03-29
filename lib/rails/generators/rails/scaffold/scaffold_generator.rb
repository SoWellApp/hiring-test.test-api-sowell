# frozen_string_literal: true

require "rails/generators/rails/resource/resource_generator"

module Rails
  module Generators
    class ScaffoldGenerator < ResourceGenerator # :nodoc:
      remove_hook_for :resource_controller
      remove_class_option :actions

      class_option :api, type: :boolean
      class_option :stylesheets, type: :boolean, desc: "Generate Stylesheets"
      class_option :stylesheet_engine, desc: "Engine for Stylesheets"
      class_option :assets, type: :boolean
      class_option :resource_route, type: :boolean
      class_option :scaffold_stylesheet, type: :boolean

      def handle_skip
        @options = @options.merge(stylesheets: false) unless options[:assets]
        return if options[:stylesheets] && options[:scaffold_stylesheet]

        @options = @options.merge(stylesheet_engine: false)
      end

      hook_for :scaffold_controller, required: true

      invoke "custom_resource"
      invoke "ability"

      hook_for :assets do |assets|
        invoke assets, [controller_name]
      end

      hook_for :stylesheet_engine do |stylesheet_engine|
        invoke stylesheet_engine, [controller_name] if behavior == :invoke
      end
    end
  end
end
