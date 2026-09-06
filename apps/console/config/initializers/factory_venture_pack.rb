# frozen_string_literal: true

repo_root = Rails.root.join("..", "..").expand_path
factory_loader = repo_root.join("factory", "loaders", "venture_pack.rb")

if factory_loader.file?
  require factory_loader.to_s
  company_loader = repo_root.join("factory", "loaders", "company_pack_loader.rb")
  require company_loader.to_s if company_loader.file?
  Rails.application.config.x.company_pack = Factory::CompanyPack.current(root: repo_root) if defined?(Factory::CompanyPack)
  Rails.application.config.x.venture_pack = Factory::VenturePack.current(root: repo_root)
end
