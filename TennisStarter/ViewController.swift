import UIKit
import AVFoundation
import CoreLocation //location services

class ViewController: UIViewController {
    let locationManager = CLLocationManager();
    var restartMatch = false;
    @IBOutlet weak var p1Button: UIButton!
    @IBOutlet weak var p2Button: UIButton!
    @IBOutlet weak var p1NameLabel: UILabel!
    @IBOutlet weak var p2NameLabel: UILabel!
    
    @IBOutlet weak var p1PointsLabel: UILabel!
    @IBOutlet weak var p2PointsLabel: UILabel!
    
    @IBOutlet weak var p1GamesLabel: UILabel!
    @IBOutlet weak var p2GamesLabel: UILabel!
    
    @IBOutlet weak var p1SetsLabel: UILabel!
    @IBOutlet weak var p2SetsLabel: UILabel!
    
    @IBOutlet weak var p1PreviousSetsLabel: UILabel!
    @IBOutlet weak var p2PreviousSetsLabel: UILabel!
    
    @IBOutlet weak var LocationLabel: UILabel!
    
    /******** Action Methods*********/
    @IBAction func p1AddPointPressed(_ sender: UIButton) {
        game.addPointToPlayer1();
        serveChange() //checks for a serve change upon new game or tie break
        if(game.player1Won()){ //player 1 has won
            gameWon.player1(); //update game logic
        }
        UIUpdateFunctions() //Call functions that will update the UI
    }
    
    @IBAction func p2AddPointPressed(_ sender: UIButton) {
        game.addPointToPlayer2();
        serveChange() //checks for a serve change upon new game or tie break
        if(game.player2Won()){ //player 2 won
            gameWon.player2(); //update game logic
        }
        UIUpdateFunctions()  //Call functions that will update the UI
    }
    
    @IBAction func restartPressed(_ sender: AnyObject) {
        Player1.ResetPlayerScores(); //reset stored scores
        Player2.ResetPlayerScores();
        player1History.clearGamesWonLabel(); //previous set label cleared for UI
        player2History.clearGamesWonLabel();
        restartMatch = true; //restarts match flag --> used in functions below
        addButtonsDisableEnable(); //enables buttons if disabled
        matchBalls.resetMatchBalls(); //reset counts in class
        serveChange() //change back to player 1 serve
        UIUpdateFunctions()
        restartMatch =  false; //turns flag off
    }
}

extension ViewController {
    //contains supporting class methods for the UI Functionality
    func UIUpdateFunctions() {
        //Updates UI with functions below -> groups thse together
        updateScores();
        displayWhoIsWinning();
        if(match.matchEnded()){
            matchEndPopUp();
        }
        storePreviousLabels();
    }

    //Match functions --> check if these can be refactored to classes
    func updateScores() {
        //updates all score labels --> called after every point add
        p1PointsLabel.text = Player1.GetPointsWon();
        p2PointsLabel.text = Player2.GetPointsWon();
        p1GamesLabel.text  = String(Player1.GetGamesWon());
        p2GamesLabel.text  = String(Player2.GetGamesWon());
        p1SetsLabel.text   = String(Player1.GetSetsWon());
        p2SetsLabel.text   = String(Player2.GetSetsWon());
    }
    func matchEndPopUp(){
        //displays the game has ended and who has won
        let alert : UIAlertController?;
        if (match.player1Sets() == 3)
            {
                alert = UIAlertController(title: "Match Ended", message: "Player 1 Won", preferredStyle: .alert);
            }
        else {
                alert = UIAlertController(title: "Match Ended", message: "Player 2 Won", preferredStyle: .alert);
            }
        alert!.addAction(UIAlertAction(title: "Close", style: .default, handler: nil));
        self.present(alert!, animated: true);
        addButtonsDisableEnable();
    }
    func addButtonsDisableEnable(){
        //disables the button on match end
        //enables buttons on match restart
        if(restartMatch){
            p2Button.isEnabled = true;
            p1Button.isEnabled = true;
        }
        else {
            p2Button.isEnabled = false;
            p1Button.isEnabled = false;
        }
    }
    func storePreviousLabels(){
        if(restartMatch){//labels on restart or start
            p1PreviousSetsLabel.text = "-";
            p2PreviousSetsLabel.text = "-";
        }
        else {
            p1PreviousSetsLabel.text! = player1History.previousGamesWonLabel; //previous set scores label
            p2PreviousSetsLabel.text! = player2History.previousGamesWonLabel;
        }
    }
    func displayWhoIsWinning() {
        //displays who has the most points, sets and games by giving the score label a green background colour
        let colourWin = UIColor(red: 0, green: 255, blue: 0, alpha: 1);
        let normalColour = UIColor(red: 1, green: 1, blue: 1, alpha: 1);
        let p1Points = Int(game.player1Score()) ?? 50; //if not an int, assume ADV
        let p2Points = Int(game.player2Score()) ?? 50;
        
        
        p1PointsLabel.backgroundColor = (p1Points > p2Points) ?  colourWin : normalColour;
        p2PointsLabel.backgroundColor = (p2Points > p1Points) ?  colourWin : normalColour;
        p1GamesLabel.backgroundColor =
             (set.player1Games() > set.player2Games()) ?  colourWin : normalColour;
            
        p2GamesLabel.backgroundColor = (set.player2Games() > set.player1Games()) ?  colourWin : normalColour;
            
        p1SetsLabel.backgroundColor = (match.player1Sets() > match.player2Sets()) ? colourWin : normalColour;
        p2SetsLabel.backgroundColor = (match.player2Sets() > match.player1Sets()) ? colourWin : normalColour;
        }
    
    func serveChange(){
        //updates the UI to have a purple background for who's serving
        let normalColour = UIColor(red: 1, green: 1, blue: 1, alpha: 1); //white
        let ServingColour = UIColor(red: 0.5, green: 0, blue: 0.5, alpha: 1); //purple
        //print("Serve function bool: \(serve.Player1NextServe()))")
        if (serve.NextServe(newMatch: restartMatch) ){
            p1NameLabel.backgroundColor = ServingColour;
            p2NameLabel.backgroundColor = normalColour;
        }
        else{
            p1NameLabel.backgroundColor = normalColour;
            p2NameLabel.backgroundColor = ServingColour;
        }
    }
}

extension ViewController: CLLocationManagerDelegate {
    //added Location services
    //Code taken and adapted from (Location Services | IOS | Swift | Andrew’s Tutorials, n.d.)
    override func viewDidLoad() {
        //super.viewDidLoad()
        //location services
        if CLLocationManager.authorizationStatus() == .notDetermined { //check for authorization
            print("Location not determined")
            self.locationManager.requestAlwaysAuthorization();  //get authorization
            self.locationManager.requestWhenInUseAuthorization();
        }
        locationManager.delegate = self //delegates to view controller
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        locationManager.startUpdatingLocation()
        locationManager.startUpdatingHeading()
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        //handle updayes to our location
        guard let locationVal : CLLocationCoordinate2D = manager.location?.coordinate else {return}
        let location : String = FindLocation().findLocation(longitude: Int(round(locationVal.longitude)), latitude: Int(round(locationVal.latitude))) //fetches location based on hardcoded coordinate ranges
        LocationLabel.text  = (location != "") ? location : "(\(locationVal.longitude),\(locationVal.latitude))";
    }
    
}
extension ViewController {
    //added match scheduling funcitonality  to calendar --> only schedules for the same day
    /*Code taken and adapted from (Jagne, 2019) & (Swift - How to Open Calendar with Event - NSURL Calshow:, n.d.)*/
    @IBAction func ScheduleMatch(_ sender: UIButton){
        //pop up
        var alert = UIAlertController(title: "Schedule Match For Today", message: "Enter title, date, duration", preferredStyle: .alert)
        //add text fields for user pop up so the user can enter title, number of hours and additional info
        alert.addTextField{
            (textField) in textField.placeholder = "Enter title for match"
        }
        /*alert.addTextField{ //issue passing date to fit into calendar
            (textField) in textField.placeholder = "Enter date for match"
        }*/
        alert.addTextField{
            (textField) in textField.placeholder = "Enter match duration(hours)"
        }
        alert.addTextField{
            (textField) in textField.placeholder = "Enter match info"
        }
        let enterAction = UIAlertAction(title: "Enter", style: .default){
            _ in
            if(CalendarObj().matchSchedulingAccess()){
                let info : String = alert.textFields![2].text ?? "";
                print("info: \(info)")
                let duration : Double = Double(alert.textFields![1].text ?? "6") ?? 6;
                print("duration: \(duration)")
                let title : String = alert.textFields![0].text ?? "new match";
                print("title: \(title)")
                CalendarObj().insertEvent(title: title,
                                          matchTimeHours: duration,
                                          info: info);
                self.showCalendarEvent();
            }
            else {
                print("access denied to calendar")
                alert = UIAlertController(title: "Unable to schedule match", message: "Please try again", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Exit", style: .cancel, handler: nil))
                self.present(alert, animated: true)
            }
        }
        alert.addAction(enterAction)
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
    
    func showCalendarEvent(){
        //shows calendar after event added
        /*code taken and adapter from(Swift - How to Open Calendar with Event - NSURL Calshow:, n.d.)*/
        guard let url = URL(string: "calshow://") else { return };
        UIApplication.shared.open(url, options: [:], completionHandler: nil);
    }
}

extension ViewController {
    //contains the UI functionality to display and invoke the writing of the data
    @IBAction func ReadData(_ sender: UIButton) {
        //should be
        let persistentData = PlayerPersistentData().Read(); //store in the label
        let alert = UIAlertController(title: "Persistent Data", message: "\(persistentData)", preferredStyle: .alert);
        
        alert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil));
        self.present(alert, animated: true);
        //UIExtension.colourChange()
    }
    @IBAction func writeData(_ sender: UIButton){
        PlayerPersistentData().Write()
    }
}

extension ViewController {
    //added player stats presented in a  pop up display --> works with UI
    @IBAction func getPlayer1Stats(_ sender: UIButton){
        let SetsWonPercentage  = getWinPercentage(winValue: player1History.getTotalSetsWon(), lossValue: player2History.getTotalSetsWon())
        let GamesWonPercentage = getWinPercentage(winValue: player1History.getTotalGamesWon(), lossValue: player2History.getTotalGamesWon())
        
        let alert = UIAlertController(title: "Player 1 Statistics",  message: "Sets Won: \(round(SetsWonPercentage))%\nGames Won: \(round(GamesWonPercentage))%", preferredStyle: .alert);
        
        alert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil));
        self.present(alert, animated: true);
    }
    @IBAction func getPlayer2Stats(_ sender: UIButton){
        let SetsWonPercentage  = getWinPercentage(winValue: player2History.getTotalSetsWon(), lossValue: player1History.getTotalSetsWon())
        let GamesWonPercentage = getWinPercentage(winValue: player2History.getTotalGamesWon(), lossValue: player1History.getTotalGamesWon())
        
        let alert = UIAlertController(title: "Player 2 Statistics",  message: "Sets Won: \(round(SetsWonPercentage))%\nGames Won: \(round(GamesWonPercentage))%", preferredStyle: .alert);

        
        alert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil));
        self.present(alert, animated: true);
    }
    private func getWinPercentage(winValue: Int, lossValue: Int) -> Double { // private as only needed for this section
        let percentage  = (Double(winValue) / Double(winValue + lossValue))*100;
        return (percentage >= 0) ? percentage : 0.0; //safety incase nil
    }
}
