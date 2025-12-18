package Level1BaseTypes {
  private import ScalarValues::String;
  private import Base::Anything;
  private import Requirements::RequirementCheck;
  private import Connections::BinaryConnection;
  private import Allocations::Allocation;

  abstract requirement def AbstractRequirement :> RequirementCheck {
    attribute id : String;
    attribute name : String;
    attribute description : String;
  }

  abstract action def AbstractBehavior {
    attribute id : String;
    attribute name : String;
    attribute description : String;
  }

  abstract part def AbstractStructure {
    attribute id : String;
    attribute name : String;
    attribute description : String;
  }

  abstract part def AbstractAssurance {
    attribute id : String;
    attribute name : String;
    attribute description : String;
  }

  abstract part def AbstractManagement {
    attribute id : String;
    attribute name : String;
    attribute description : String;
  }

  connection def Refines :> BinaryConnection {
    end refining: AbstractRequirement :>> BinaryConnection::source;
    end refined: AbstractRequirement :>> BinaryConnection::target;
  }

  connection def SatisfiedBy :> BinaryConnection {
    end requirement: AbstractRequirement :>> BinaryConnection::source;
    end structure: AbstractStructure :>> BinaryConnection::target;
  }

  allocation def AllocatedTo :> Allocation {
    end behavior: AbstractBehavior :>> Allocation::source;
    end structure: AbstractStructure :>> Allocation::target;
  }

  connection def Performs :> BinaryConnection {
    end structure: AbstractStructure :>> BinaryConnection::source;
    end behavior: AbstractBehavior :>> BinaryConnection::target;
  }

  connection def Consumes :> BinaryConnection {
    end behavior: AbstractBehavior :>> BinaryConnection::source;
    end resource: AbstractStructure :>> BinaryConnection::target;
  }

  connection def Produces :> BinaryConnection {
    end behavior: AbstractBehavior :>> BinaryConnection::source;
    end resource: AbstractStructure :>> BinaryConnection::target;
  }

  connection def Verifies :> BinaryConnection {
    end assurance: AbstractAssurance :>> BinaryConnection::source;
    end requirement: AbstractRequirement :>> BinaryConnection::target;
  }

  connection def Inspects :> BinaryConnection {
    end assurance: AbstractAssurance :>> BinaryConnection::source;
    end structure: AbstractStructure :>> BinaryConnection::target;
  }

  connection def Impacts :> BinaryConnection {
    end management: AbstractManagement :>> BinaryConnection::source;
    end target: Anything :>> BinaryConnection::target;
  }

  connection def Documents :> BinaryConnection {
    end management: AbstractManagement :>> BinaryConnection::source;
    end artifact: Anything :>> BinaryConnection::target;
  }
}
