require 'gem2deb/rake/testtask'

Gem2Deb::Rake::TestTask.new do |t|
  t.libs = ['test']
  if ENV['AUTOPKGTEST_TEST_PUMA_SERVER_SSL']
    ENV['OPENSSL_CONF'] = '' # https://github.com/puma/puma/issues/2147
    t.test_files = FileList['test/test_*_ssl.rb']
  else
    t.test_files = FileList['test/**/*_test.rb'] + FileList['test/**/test_*.rb'] - FileList[
      'test/test_*ssl.rb',
      'test/test_integration_cluster.rb',
      'test/test_worker_gem_independence.rb',
      'test/test_rack_version_restriction.rb',
      'test/test_preserve_bundler_env.rb',
    ]
  end
  t.verbose = true
end.tap do |t|
  exclude = %w[
    test_application_logs_are_flushed_on_write
    test_hot_restart_does_not_drop_connections
    test_logs_all_localhost_bindings
    test_multiple_requests_waiting_on_less_busy_worker
    test_term_not_accepts_new_connections
    test_prune_bundler_with_multiple_workers
  ]
  t.options << ' ' << "-e'/" << exclude.join('|') << "/'"
end
