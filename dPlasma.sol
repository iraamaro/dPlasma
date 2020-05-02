// import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC721/ERC721.sol";
pragma solidity 0.6.0 ;

    
contract dPlasma {
    
    // state variables
    
    enum BloodTypes {A_Plus, A_Minus, B_Plus, B_Minus, AB_Plus, AB_Minus, O_Plus, O_Minus }
    
    // ERC721Mintable tokenContract;
    
    struct Donor {
        address donorAddress;
        string city;
        BloodTypes bloodType;
        uint birthDate;
        //person must be between 18 and 50
        uint bodyWeight;
        //person must be heavier than 110 llbs (50kg) to donate
        uint lastDonation;
        //if date is less than 4 weeks, person is not available to donate
        bool serologicalTestIsPositive;
        //if true (and we want TRUE)>>> person has antibodies, if false, not eligible to do clinical trials or donate plasma for CPP
        uint dateOfFirstSymptom;
        uint dateOfLastSymptom;
        bool pcrResultIsNegative;
        //if true (and we want TRUE)>>> person is not infected with SARS-Covid-19, if false, person tested positive hence, person has the virus and cant donate plasma for CPP
        bool active;
        bool isFemale;
        bool hadAnyPregnanciesorMiscarriagesMoreThanTwiceIsTrue;
        //if true >>> risks of TRALI (transfusion-related acute lung injury), person can't donate plasma or she might kill the patient of lung complication
        uint lastTattoo;
        //if date is less than 12 months from now, person can't donate
    }
    
    mapping (address => Donor) public donors;
    
    struct Patient {
        address patientAddress;
        string city;
        string hospital;
        BloodTypes bloodType;
        bool isINDregistered;
        //Investigational New Drug (IND) >> sick/terminal patients or family members must sign 
        //TODO: encher com as variaveis daqui: https://www.nybc.org/donate-blood/covid-19-and-blood-donation-copy/convalescent-plasma-information-family-patient-advocates/
    }
    
    mapping (address => Patient) public patients;
    
    struct BloodBank {
        address bloodbankAddress;
        string city;
         //TODO: encher com as variaveis daqui: https://www.oneblood.org/
    }
    
    struct Hospital{
        address hospitalAddress;
        string city;
    }
    
    struct Doctor{
        address doctorAddress;
        bool ishematologistDoctor;
        //only hematologistDoctor can sign the transaction to receive 
    }
     struct hematologistDoctor is Doctor {
        address hematologistAddress;
        bool isHematologist;
        string city;
         //TODO: encher com as variaveis daqui: https://www.oneblood.org/
    }
    
    //TODO: Se der tempo, construir a Struct do hospital: https://www.nybc.org/donate-blood/covid-19-and-blood-donation-copy/convalescent-plasma-information-healthcare-providers/
    
    
    mapping (address => BloodBank) public bloodBanks;
    
    struct Donation {
        uint startDate;
        bool hasDonated;
        address patientAddress;
        address donorAddress;
        address bloodbankAddress;
    }
    
    mapping (uint => Donation) public donations;
    uint public donationCount;
    
    // events
    event NewDonor(address donorAddress, string city, BloodTypes bloodType);
    event DonorChanges(address donorAddress, string city, uint lastTattoo, uint lastDonation);
    event NewPatient(address patientAddress, string city, BloodTypes bloodType);
    event NewBloodBank(address bloodbankAddress, string city);
    event Donated(address patientAddress, address donorAddress);
    event DonationHappened(uint id);
    
    
    // functions
    // constructor (address _tokenAddress) public {
    //     tokenContract = ERC721Mintable(_tokenAddress);
    // }
    
    function donorSignup(
        string memory city,
        BloodTypes bloodType,
        uint birthDate,
        uint lastTattoo,
        uint lastDonation`
        ) public {
            
        // criou a struct na memória
        Donor memory newDonor = Donor(
            msg.sender,
            city,
            bloodType,
            birthDate,
            lastTattoo,
            lastDonation,
            true);
        
        // inserindo a struct no mapping (state)
        donors[msg.sender] = newDonor;
        
        // emitindo evento
        emit NewDonor (msg.sender, city, bloodType);
    }
    
    function donorChanges(
        string memory city,
        uint lastTattoo,
        uint lastDonation
        ) public {
        require(donors[msg.sender].donorAddress != address(0), "Donor not found.");
            
        // criou um storage pointer
        Donor storage donor = donors[msg.sender];
        
        donor.city = city;
        donor.lastTattoo = lastTattoo;
        donor.lastDonation = lastDonation;
        //emit
       emit DonorChanges (msg.sender, city, lastTattoo, lastDonation);
    }
    
    // 2do patient - patientSignup
    function patientSignup(
        string memory city,
        BloodTypes bloodType
        ) public {
            
        // criou a struct na memória
        Patient memory newPatient = Patient(
            msg.sender,
            city,
            bloodType);
              
        // inserindo a struct no mapping (state)
        patients[msg.sender] = newPatient;
        
        // emitindo evento
        emit NewPatient (msg.sender, city, bloodType);
    }
        
    // 2do bank
    function bloodbankSignup(
        string memory city
        ) public {
            
        // criou a struct na memória
        BloodBank memory newBloodBank = BloodBank(
            msg.sender,
            city);
              
        // inserindo a struct no mapping (state)
        bloodBanks[msg.sender] = newBloodBank;
        
        // emitindo evento
      emit NewBloodBank (msg.sender, city);
    }
    
    // donations scheduled
    // called by donors
    function donationScheduled(address patientAddress) public {
        require(donors[msg.sender].donorAddress != address(0), "Caller is not a donor");
        require(patients[patientAddress].patientAddress != address(0), "Patient does not exist");
        //require(bloodBanks[bloodbankAddress].bloodbankAddress != address(0), "Blood Bank does not exist");
        
        // criou o struct na mem'ória
        Donation memory newDonation = Donation (
            now,
            false,
            patientAddress,
            msg.sender,
            address(0)
            );
        
        donationCount++;
        
        // gravou o struct no mapping (estado)
        donations[donationCount] = newDonation;
        
        // 2do event
       emit Donated (msg.sender, patientAddress);
    }
    
    modifier onlyBloodBank {
        require(bloodBanks[msg.sender].bloodbankAddress != address(0), "Caller is not a blood bank");
        _;
    }
    
    // donations executed
    // called by banks only
    function donationHappened (uint donationId) public onlyBloodBank {
        
        Donation storage donation = donations[donationId];
        require(donation.startDate != 0, "Donation not found");
        require(donation.hasDonated == false, "Donation has already happened");
        
        donation.hasDonated = true;
        donation.bloodbankAddress = msg.sender;
        
        // event 
        emit DonationHappened(donationId);
        
        // issue NFT to donor
        // tokenContract.mint(donation.donorAddress, donationId);
        
    }
}