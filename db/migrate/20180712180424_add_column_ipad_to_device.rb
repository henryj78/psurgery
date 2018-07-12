class AddColumnIpadToDevice < ActiveRecord::Migration[5.2]
  def change
    add_column :devices, :ipad, :string
    add_column :devices, :iphone, :string
    add_column :devices, :mobile, :string
    add_column :devices, :surface, :string
    add_column :devices, :tablet, :string
    add_column :devices, :platform_name, :string
    add_column :devices, :platform_version, :string
    add_column :devices, :android, :string
    add_column :devices, :platform_ios, :string
    add_column :devices, :linux, :string
    add_column :devices, :mac_platform, :string
    add_column :devices, :other_platform, :string
    add_column :devices, :windows_platform, :string
    add_column :devices, :windows_mobile, :string
    add_column :devices, :windows_phone, :string
  end
end
