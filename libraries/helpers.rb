module SonarrCookbook
  module Helpers
    def mono_repo_distribution(repo_name)
      repo_table[repo_name][:distribution]
    end

    def mono_repo_fullname(repo_name)
      repo_table[repo_name].fetch(:name) do
        repo_name =~ /^mono/ ? repo_name : "mono-#{repo_name}"
      end
    end

    def group_for_daemon_user(username)
      username == 'root' ? 'root' : 'nogroup'
    end

    protected

    def repo_table
      {
        'mono-xamarin' => { distribution: 'wheezy' },
        'base' => { distribution: 'wheezy', name: 'mono-xamarin' },
        'mod_mono' => { distribution: 'wheezy-apache24-compat' },
        'libgdiplus' => { distribution: 'wheezy-libjpeg62-compat' },
        'libtiff' => { distribution: 'wheezy-libtiff-compat' }
      }
    end
  end
end
