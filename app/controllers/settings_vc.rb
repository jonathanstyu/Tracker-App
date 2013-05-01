class SettingsViewController < UIViewController
  include MotionTable::GroupedTable
  
  def viewDidLoad
    super
    self.title = "Settings"
    @grouped_table_view_data ||= [{
      title: "Game Recording Settings",
      cells: [
        {title: "3 pointers allowed", accessoryAction: :toggle_3pts, accessory: :switch, accessoryDefault: true},
        {title: "2pts / 3pts", accessoryAction: :toggle_12, accessory: :switch, accessoryDefault: true},
        {title: "Unequal teams allowed?", accessoryAction: :toggle_team_num, accessory: :switch, accessoryDefault: false}
      ]
    }, {
      title: "App Made With ...", 
      cells: [
        {title: "Rubymotion"}, 
        {title: "Bubblewrap"},
        {title: "Motion-Model"},
        {title: "Sugarcube"}
      ]
    }]
    self.view = self.createTableViewFromData(@grouped_table_view_data)
  end

  def viewDidUnload
    super
  end

  def shouldAutorotateToInterfaceOrientation(interfaceOrientation)
    interfaceOrientation == UIInterfaceOrientationPortrait
  end
  
  def toggle_3pts(args)
    App::Persistence['3pts'] = args[:value]
  end
  
  def toggle_12(args)
    App::Persistence['12pts'] = args[:value]
  end
  
  def toggle_team_num(args)
    App::Persistence['teamnumb'] = args[:value]
  end
  
end
