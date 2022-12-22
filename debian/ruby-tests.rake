require 'gem2deb/rake/testtask'

Gem2Deb::Rake::TestTask.new do |t|
  t.libs = ['test']
  if ENV['AUTOPKGTEST_TEST_PUMA_SERVER_SSL']
    ENV['OPENSSL_CONF'] = '' # https://github.com/puma/puma/issues/2147
    t.test_files = FileList['test/test_*_ssl.rb']
  else
    t.test_files = FileList['test/**/*_test.rb'] + FileList['test/**/test_*.rb'] - FileList[
      'test/test_*ssl.rb',
      'test/test_integration_systemd.rb',
      'test/test_integration_cluster.rb',
      'test/test_integration_pumactl.rb',
      'test/test_worker_gem_independence.rb',
      'test/test_preserve_bundler_env.rb',
    ]
  end
  t.verbose = true
end
