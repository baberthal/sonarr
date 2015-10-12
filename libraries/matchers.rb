if defined?(ChefSpec)
  def add_mono_repo(name)
    ChefSpec::Matchers::ResourceMatcher.new(:sonarr_mono_repo, :add, name)
  end

  def create_sonarr_init_service(name)
    ChefSpec::Matchers::ResourceMatcher.new(:sonarr_init_service, :create, name)
  end
end
