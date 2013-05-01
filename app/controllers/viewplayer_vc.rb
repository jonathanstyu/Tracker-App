class ViewplayerViewController < UIViewController
  attr_accessor :player
  
  def viewDidLoad
    super
    self.title = "#{player.player_name}"
    view.backgroundColor = :white.uicolor
    layout_views
  end
  
  def initWithPlayer(player)
    initWithNibName(nil, bundle:nil)
    self.player = player
    self
  end

  def layout_views
    scr_width = view.bounds.width
    scr_height = view.bounds.height
    
    name_label = UILabel.new
    name_label.frame = CGRect.make(x: scr_width * 0.1, y:0, width: scr_width / 2, height: scr_height / 10)
    name_label.text = player.player_name
    name_label.font = "Avenir-Black".uifont(22)
    name_label.backgroundColor = :clear.uicolor 
    view << name_label
    
    @performance_table = UITableView.new 
    @performance_table.frame = CGRect.make(x: 0, y: scr_width / 6, width: scr_width, height: scr_height - name_label.frame.height)
    @performance_table.delegate = @performance_table.dataSource = self
    @performance_table.rowHeight = 130
    @performance_table.backgroundColor = :clear.uicolor
    @performance_table.addPullToRefreshWithActionHandler(
    Proc.new do 
      loadData
    end
    )
    view << @performance_table
  end
  
  def tableView(tableView, numberOfRowsInSection: section)
    @performances = Performance.where(:player_dat).eq(player.id).all.reverse
    return @performances.count
  end
  
  def tableView(tableView, cellForRowAtIndexPath: indexPath)
    @reuseIdentifier ||= "CELL_IDENTIFIER"
    cell = tableView.dequeueReusableCellWithIdentifier(@reuseIdentifier) || begin
      cell = ProfileCell.alloc.initWithStyle(UITableViewCellStyleValue1, reuseIdentifier:@reuseIdentifier)
      cell.createLabels
      cell
    end
    performance = @performances[indexPath.row]

    cell.date_label.text = performance.game_name
    cell.points_label.text = performance.points.to_s
    cell.fg_label.text = "#{performance.made_field_goals.to_s}/#{performance.total_field_goals.to_s}"
    cell.rebounds_label.text = performance.rebounds.to_s
    cell.assists_label.text = performance.assists.to_s
    cell.steals_label.text = performance.steals.to_s
    cell.blocks_label.text = performance.blocks.to_s
    
    cell
  end

  def viewDidUnload
    super
    # Release any retained subviews of the main view.
  end

  def shouldAutorotateToInterfaceOrientation(interfaceOrientation)
    interfaceOrientation == UIInterfaceOrientationPortrait
  end
  
  def loadData
    Dispatch::Queue.main.after(2) {
      @performance_table.reloadData
      @performance_table.pullToRefreshView.stopAnimating
    }
  end
  
end
