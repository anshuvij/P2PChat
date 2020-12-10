//
//  MainViewController.swift
//  P2P
//
//  Created by Anshu Vij on 12/8/20.
//

import UIKit
import CoreBluetooth

class MainViewController: UIViewController {
    
    var visibleDevices = Array<Device>()
    var cachedDevices = Array<Device>()
    var cachedPeripheralNames = Dictionary<String, String>()
    var timer = Timer()
    
    var peripheralManager = CBPeripheralManager()
    var centralManager: CBCentralManager?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Log Out", style: .plain, target: self, action: #selector(logOutTapped))
        navigationItem.rightBarButtonItem?.tintColor = .white
        
        centralManager = CBCentralManager(delegate: self, queue: DispatchQueue.main)
        peripheralManager = CBPeripheralManager(delegate: self, queue: nil, options: nil)
            
        tableView.register(UINib(nibName: Constants.cellNibName, bundle: nil), forCellReuseIdentifier: Constants.cellIdentifier)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        scheduledTimerWithTimeInterval()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        updateAdvertisingData()
    }
    
    
    @objc func logOutTapped() {
        
        UserDefaults.standard.removeObject(forKey: "userData")
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        _ = UINavigationController(rootViewController: vc)
        self.navigationController?.pushViewController(vc, animated: true)
    
    }
    
    func updateAdvertisingData() {
        
        if (peripheralManager.isAdvertising) {
            peripheralManager.stopAdvertising()
        }
        
        let userData = UserData()
        let advertisementData = String(format: "%@|%d", userData.name, userData.number)
        
        peripheralManager.startAdvertising([CBAdvertisementDataServiceUUIDsKey:[Constants.SERVICE_UUID], CBAdvertisementDataLocalNameKey: advertisementData])
    }
    
    func scheduledTimerWithTimeInterval(){
        
        timer = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(self.clearPeripherals), userInfo: nil, repeats: true)
    }
    
    @objc func clearPeripherals(){
        
        visibleDevices = cachedDevices
        cachedDevices.removeAll()
        tableView?.reloadData()
    }
    
    func addOrUpdatePeripheralList(device: Device, list: inout Array<Device>) {

        if !list.contains(where: { $0.peripheral.identifier == device.peripheral.identifier }) {
            
            list.append(device)
          //  tableView?.reloadData()
        }
        else if list.contains(where: { $0.peripheral.identifier == device.peripheral.identifier
            && $0.name == "unknown"}) && device.name != "unknown" {
            
            for index in 0..<list.count {
                
                if (list[index].peripheral.identifier == device.peripheral.identifier) {
                    
                    list[index].name = device.name
                    tableView?.reloadData()
                    break
                }
            }
            
        }
    }

}

extension MainViewController : UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return visibleDevices.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath as IndexPath) as! DiscoveryCell
        
        let device = visibleDevices[indexPath.row]
        
        let advertisementData = device.name.components(separatedBy: "|")
        
        if (advertisementData.count > 1) {
            
            cell.nameLabel?.text = advertisementData[0]
            cell.phoneNumberLabel.text = advertisementData[1]
        }
        else {
            cell.nameLabel?.text = device.name
            cell.phoneNumberLabel.text = "0"
        }
        return cell
    }
    
    
}

extension MainViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let chatViewController = ChatViewController()
        chatViewController.deviceUUID = visibleDevices[indexPath.row].peripheral.identifier
        chatViewController.deviceAttributes = visibleDevices[indexPath.row].name
        self.navigationController?.pushViewController(chatViewController, animated: true)
    }
    
}

extension MainViewController : CBPeripheralManagerDelegate {
    
    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        
        if (peripheral.state == .poweredOn){
            
            updateAdvertisingData()
        }
    }
}

extension MainViewController : CBCentralManagerDelegate {
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if (central.state == .poweredOn){
            
            self.centralManager?.scanForPeripherals(withServices: [Constants.SERVICE_UUID], options: [CBCentralManagerScanOptionAllowDuplicatesKey : true])
            
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        
        var peripheralName = cachedPeripheralNames[peripheral.identifier.description] ?? "unknown"
        
        if let advertisementName = advertisementData[CBAdvertisementDataLocalNameKey] as? String {
            
            peripheralName = advertisementName
            cachedPeripheralNames[peripheral.identifier.description] = peripheralName
        }
        
        let device = Device(peripheral: peripheral, name: peripheralName)
        
        self.addOrUpdatePeripheralList(device: device, list: &visibleDevices)
        self.addOrUpdatePeripheralList(device: device, list: &cachedDevices)
    }
}

