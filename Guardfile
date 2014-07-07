group :specs do
  guard :rspec, cmd: 'spring rspec' do
    # run every updated spec file
    watch(%r{^spec/.+_spec\.rb$})
    # run the lib specs when a file in lib/ changes
    watch(%r{^lib/(.+)\.rb$}) { |m| "spec/lib/#{m[1]}_spec.rb" }
    # run the model specs related to the changed model
    watch(%r{^app/(.+)\.rb$}) { |m| "spec/#{m[1]}_spec.rb" }
    # run the view specs related to the changed view
    watch(%r{^app/(.*)(\.erb|\.haml)$}) { |m| "spec/#{m[1]}#{m[2]}_spec.rb" }
    # run the integration specs related to the changed controller
    watch(%r{^app/controllers/(.+)\.rb}) { |m| "spec/features/#{m[1]}_spec.rb" }
    # run all integration tests when application controller changes
    watch('app/controllers/application_controller.rb') { "spec/features" }
  end

  guard 'cucumber', command_prefix: 'spring', cli: '--no-profile --color --format progress --strict', all_after_pass: false, all_on_start: false, keep_failed: false, bundler: false do
    # run every updated feature
    watch(%r{^features/.+\.feature$})
    # run all features when any supporting files change
    watch(%r{^features/support/.+$}) { 'features' }
    # run feature related to changed step definition, if no feature found then run all features
    watch(%r{^features/step_definitions/(.+)_steps\.rb$}) { |m| Dir[File.join("**/#{m[1]}.feature")][0] || 'features' }
  end
end
