class PlayerEditViewController < UIViewController
  
  def viewDidLoad
    super
    self.title = "Player Edit"
    # Do any additional setup after loading the view.
  end

  def viewDidUnload
    super
    # Release any retained subviews of the main view.
  end

  def shouldAutorotateToInterfaceOrientation(interfaceOrientation)
    interfaceOrientation == UIInterfaceOrientationPortrait
  end
end
