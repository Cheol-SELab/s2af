
package Level3ArchitectureTypes {
  private import ScalarValues::String;
  private import Base::Anything;
  private import Connections::BinaryConnection;
  private import Allocations::Allocation;
  private import Metadata::MetadataItem;
  private import Level1BaseTypes::*;
  private import Level2DomainTypes::*;

  // ========== Level 3 Architecture Element Types (NEW - not in Level 2) ==========

  part def Architecture :> AbstractStructure {
    metadata def Achieves :> RelationshipSpec {
      targetTypes = ("Mission");
    }
    metadata def AssignedTo :> RelationshipSpec {
      targetTypes = ("Organization");
    }
    metadata def AugmentedBy :> RelationshipSpec {
      targetTypes = ("Attachment");
    }
    metadata def ComposedOf :> RelationshipSpec {
      targetTypes = ("Component", "Performer");
    }
    metadata def DocumentedBy :> RelationshipSpec {
      targetTypes = ("Document");
    }
    metadata def ImplementedBy :> RelationshipSpec {
      targetTypes = ("ProjectUnit");
    }
    metadata def SpecifiedBy :> RelationshipSpec {
      targetTypes = ("Capability", "Requirement");
    }
  }

  action def Capability :> AbstractBehavior {
    metadata def AugmentedBy :> RelationshipSpec {
      targetTypes = ("Attachment");
    }
    metadata def BasedOn :> RelationshipSpec {
      targetTypes = ("OperationalActivity");
    }
    metadata def BasisOf :> RelationshipSpec {
      targetTypes = ("OperationalActivity");
    }
    metadata def DocumentedBy :> RelationshipSpec {
      targetTypes = ("Document");
    }
    metadata def ImplementedBy :> RelationshipSpec {
      targetTypes = ("Requirement");
    }
    metadata def RefinedBy :> RelationshipSpec {
      targetTypes = ("Capability");
    }
    metadata def ResultOf :> RelationshipSpec {
      targetTypes = ("OperationalActivity");
    }
    metadata def SpecifiedBy :> RelationshipSpec {
      targetTypes = ("Requirement");
    }
    metadata def Specifies :> RelationshipSpec {
      targetTypes = ("Architecture", "CommunicationPath", "OperationalItem", "Performer", "State");
    }
    metadata def SuppliedBy :> RelationshipSpec {
      targetTypes = ("ProjectUnit");
    }
  }

  part def Classification :> Category {
    metadata def Classifies :> RelationshipSpec {
      targetTypes = ("Glossary", "Document", "Attachment", "AuxiliaryElement", "Text");
    }
  }

  action def Mission :> AbstractBehavior {
    metadata def AchievedBy :> RelationshipSpec {
      targetTypes = ("Architecture", "OperationalActivity", "OperationalTask");
    }
    metadata def AssignedTo :> RelationshipSpec {
      targetTypes = ("Organization");
    }
    metadata def AugmentedBy :> RelationshipSpec {
      targetTypes = ("Attachment");
    }
    metadata def DocumentedBy :> RelationshipSpec {
      targetTypes = ("Document");
    }
    metadata def Includes :> RelationshipSpec {
      targetTypes = ("Mission");
    }
  }

  part def CommunicationPath :> Link {
    metadata def ConnectsTo :> RelationshipSpec {
      targetTypes = ("Component", "Performer");
    }
    metadata def ImplementedBy :> RelationshipSpec {
      targetTypes = ("Link");
    }
    metadata def Includes :> RelationshipSpec {
      targetTypes = ("CommunicationPath");
    }
    metadata def SpecifiedBy :> RelationshipSpec {
      targetTypes = ("Requirement");
    }
    metadata def Transfers :> RelationshipSpec {
      targetTypes = ("OperationalItem");
    }
  }

  action def OperationalActivity :> Function {
    metadata def Achieves :> RelationshipSpec {
      targetTypes = ("Mission");
    }
    metadata def AllocatedTo :> RelationshipSpec {
      targetTypes = ("Performer");
    }
    metadata def BasedOn :> RelationshipSpec {
      targetTypes = ("OperationalTask", "Requirement");
    }
    metadata def BasisOf :> RelationshipSpec {
      targetTypes = ("Capability", "OperationalActivity", "Requirement");
    }
    metadata def DecomposedBy :> RelationshipSpec {
      targetTypes = ("OperationalActivity");
    }
    metadata def Elaborates :> RelationshipSpec {
      targetTypes = ("OperationalActivity", "Scenario");
    }
    metadata def ImplementedBy :> RelationshipSpec {
      targetTypes = ("Function");
    }
    metadata def IncorporatedBy :> RelationshipSpec {
      targetTypes = ("State");
    }
    metadata def Inputs :> RelationshipSpec {
      targetTypes = ("OperationalItem");
    }
    metadata def Outputs :> RelationshipSpec {
      targetTypes = ("OperationalItem");
    }
    metadata def ResultsIn :> RelationshipSpec {
      targetTypes = ("Capability", "Requirement");
    }
    metadata def Services :> RelationshipSpec {
      targetTypes = ("Transition");
    }
    metadata def SpecifiedBy :> RelationshipSpec {
      targetTypes = ("Requirement");
    }
  }

  part def OperationalItem :> Item {
    metadata def AssignedTo :> RelationshipSpec {
      targetTypes = ("Event");
    }
    metadata def DecomposedBy :> RelationshipSpec {
      targetTypes = ("OperationalItem");
    }
    metadata def ImplementedBy :> RelationshipSpec {
      targetTypes = ("Item");
    }
    metadata def InputTo :> RelationshipSpec {
      targetTypes = ("OperationalActivity");
    }
    metadata def OutputFrom :> RelationshipSpec {
      targetTypes = ("OperationalActivity");
    }
    metadata def Outputs :> RelationshipSpec {
      targetTypes = ("OperationalActivity");
    }
    metadata def SpecifiedBy :> RelationshipSpec {
      targetTypes = ("Requirement");
    }
    metadata def TransferredBy :> RelationshipSpec {
      targetTypes = ("CommunicationPath");
    }
    metadata def Transfers :> RelationshipSpec {
      targetTypes = ("OperationalItem");
    }
  }

  action def OperationalTask :> AbstractBehavior {
    metadata def AchievedBy :> RelationshipSpec {
      targetTypes = ("OperationalActivity");
    }
    metadata def Achieves :> RelationshipSpec {
      targetTypes = ("Mission");
    }
    metadata def AugmentedBy :> RelationshipSpec {
      targetTypes = ("Attachment");
    }
    metadata def DocumentedBy :> RelationshipSpec {
      targetTypes = ("Document");
    }
    metadata def Includes :> RelationshipSpec {
      targetTypes = ("OperationalTask");
    }
  }

  part def Performer :> AbstractStructure {
    metadata def AssignedTo :> RelationshipSpec {
      targetTypes = ("Organization");
    }
    metadata def BuiltFrom :> RelationshipSpec {
      targetTypes = ("Performer");
    }
    metadata def BuiltIn :> RelationshipSpec {
      targetTypes = ("Performer");
    }
    metadata def Composes :> RelationshipSpec {
      targetTypes = ("Architecture");
    }
    metadata def ConnectedTo :> RelationshipSpec {
      targetTypes = ("CommunicationPath");
    }
    metadata def Contains :> RelationshipSpec {
      targetTypes = ("Mode");
    }
    metadata def ImplementedBy :> RelationshipSpec {
      targetTypes = ("Component");
    }
    metadata def Performs :> RelationshipSpec {
      targetTypes = ("OperationalActivity");
    }
    metadata def SpecifiedBy :> RelationshipSpec {
      targetTypes = ("Requirement");
    }
    metadata def SuppliedBy :> RelationshipSpec {
      targetTypes = ("ProjectUnit");
    }
  }

  part def ServiceContract :> Document {
    metadata def Documents :> RelationshipSpec {
      targetTypes = ("Component");
    }
  }

  part def AuxiliaryElement :> AbstractStructure {}

  // ========== Level 3 Relationship Types (Connection/Allocation Definitions) ==========

  connection def AccomplishedBy :> BinaryConnection {
    end source : Anything :>> BinaryConnection::source;
    end target : Anything :>> BinaryConnection::target;
  }

  connection def Accomplishes :> BinaryConnection {
    end source : Anything :>> BinaryConnection::source;
    end target : Anything :>> BinaryConnection::target;
  }

  connection def AchievedBy :> BinaryConnection {
    end source : Anything :>> BinaryConnection::source;
    end target : Anything :>> BinaryConnection::target;
  }

  connection def Achieves :> BinaryConnection {
    end source : Anything :>> BinaryConnection::source;
    end target : Anything :>> BinaryConnection::target;
  }

  allocation def AllocatedTo :> Allocation {
    end source : Anything :>> Allocation::source;
    end target : Anything :>> Allocation::target;
  }

  connection def AssignedTo :> BinaryConnection {
    end source : Anything :>> BinaryConnection::source;
    end target : Anything :>> BinaryConnection::target;
  }

  connection def AugmentedBy :> BinaryConnection {
    end source : Anything :>> BinaryConnection::source;
    end target : Anything :>> BinaryConnection::target;
  }

  connection def Augments :> BinaryConnection {
    end source : Anything :>> BinaryConnection::source;
    end target : Anything :>> BinaryConnection::target;
  }

  connection def BasedOn :> BinaryConnection {
    end source : Anything :>> BinaryConnection::source;
    end target : Anything :>> BinaryConnection::target;
  }

  connection def BasisOf :> BinaryConnection {
    end source : Anything :>> BinaryConnection::source;
    end target : Anything :>> BinaryConnection::target;
  }

  connection def BuiltFrom :> BinaryConnection {
    end source : Anything :>> BinaryConnection::source;
    end target : Anything :>> BinaryConnection::target;
  }

  connection def BuiltIn :> BinaryConnection {
    end source : Anything :>> BinaryConnection::source;
    end target : Anything :>> BinaryConnection::target;
  }

  connection def CausedBy :> BinaryConnection {
    end source : Anything :>> BinaryConnection::source;
    end target : Anything :>> BinaryConnection::target;
  }

  connection def Causes :> BinaryConnection {
    end source : Anything :>> BinaryConnection::source;
    end target : Anything :>> BinaryConnection::target;
  }

  connection def Classifies :> BinaryConnection {
    end source : Anything :>> BinaryConnection::source;
    end target : Anything :>> BinaryConnection::target;
  }

  connection def ComposedOf :> BinaryConnection {
    end source : Anything :>> BinaryConnection::source;
    end target : Anything :>> BinaryConnection::target;
  }

  connection def Composes :> BinaryConnection {
    end source : Anything :>> BinaryConnection::source;
    end target : Anything :>> BinaryConnection::target;
  }

  connection def ConnectedTo :> BinaryConnection {
    end source : Anything :>> BinaryConnection::source;
    end target : Anything :>> BinaryConnection::target;
  }

  connection def ConnectsTo :> BinaryConnection {
    end source : Anything :>> BinaryConnection::source;
    end target : Anything :>> BinaryConnection::target;
  }

  connection def ContainedBy :> BinaryConnection {
    end source : Anything :>> BinaryConnection::source;
    end target : Anything :>> BinaryConnection::target;
  }

  connection def Contains :> BinaryConnection {
    end source : Anything :>> BinaryConnection::source;
    end target : Anything :>> BinaryConnection::target;
  }

  connection def CoordinatesWith :> BinaryConnection {
    end source : Anything :>> BinaryConnection::source;
    end target : Anything :>> BinaryConnection::target;
  }

  connection def DecomposedBy :> BinaryConnection {
    end source : Anything :>> BinaryConnection::source;
    end target : Anything :>> BinaryConnection::target;
  }

  connection def Describes :> BinaryConnection {
    end source : Anything :>> BinaryConnection::source;
    end target : Anything :>> BinaryConnection::target;
  }

  connection def DocumentedBy :> BinaryConnection {
    end source : Anything :>> BinaryConnection::source;
    end target : Anything :>> BinaryConnection::target;
  }

  connection def Documents :> BinaryConnection {
    end source : Anything :>> BinaryConnection::source;
    end target : Anything :>> BinaryConnection::target;
  }

  connection def ElaboratedBy :> BinaryConnection {
    end source : Anything :>> BinaryConnection::source;
    end target : Anything :>> BinaryConnection::target;
  }

  connection def Elaborates :> BinaryConnection {
    end source : Anything :>> BinaryConnection::source;
    end target : Anything :>> BinaryConnection::target;
  }

  connection def Elicits :> BinaryConnection {
    end source : Anything :>> BinaryConnection::source;
    end target : Anything :>> BinaryConnection::target;
  }

  connection def EncompassedBy :> BinaryConnection {
    end source : Anything :>> BinaryConnection::source;
    end target : Anything :>> BinaryConnection::target;
  }

  connection def Encompasses :> BinaryConnection {
    end source : Anything :>> BinaryConnection::source;
    end target : Anything :>> BinaryConnection::target;
  }

  connection def EnteredBy :> BinaryConnection {
    end source : Anything :>> BinaryConnection::source;
    end target : Anything :>> BinaryConnection::target;
  }

  connection def Enters :> BinaryConnection {
    end source : Anything :>> BinaryConnection::source;
    end target : Anything :>> BinaryConnection::target;
  }

  connection def ExhibitedBy :> BinaryConnection {
    end source : Anything :>> BinaryConnection::source;
    end target : Anything :>> BinaryConnection::target;
  }

  connection def Exhibits :> BinaryConnection {
    end source : Anything :>> BinaryConnection::source;
    end target : Anything :>> BinaryConnection::target;
  }

  connection def ExitedBy :> BinaryConnection {
    end source : Anything :>> BinaryConnection::source;
    end target : Anything :>> BinaryConnection::target;
  }

  connection def Exits :> BinaryConnection {
    end source : Anything :>> BinaryConnection::source;
    end target : Anything :>> BinaryConnection::target;
  }

  connection def ExtendedBy :> BinaryConnection {
    end source : Anything :>> BinaryConnection::source;
    end target : Anything :>> BinaryConnection::target;
  }

  connection def GeneralizationOf :> BinaryConnection {
    end source : Anything :>> BinaryConnection::source;
    end target : Anything :>> BinaryConnection::target;
  }

  connection def ImpactedBy :> BinaryConnection {
    end source : Anything :>> BinaryConnection::source;
    end target : Anything :>> BinaryConnection::target;
  }

  connection def ImplementedBy :> BinaryConnection {
    end source : Anything :>> BinaryConnection::source;
    end target : Anything :>> BinaryConnection::target;
  }

  connection def Implements :> BinaryConnection {
    end source : Anything :>> BinaryConnection::source;
    end target : Anything :>> BinaryConnection::target;
  }

  connection def IncludedIn :> BinaryConnection {
    end source : Anything :>> BinaryConnection::source;
    end target : Anything :>> BinaryConnection::target;
  }

  connection def Includes :> BinaryConnection {
    end source : Anything :>> BinaryConnection::source;
    end target : Anything :>> BinaryConnection::target;
  }

  connection def IncorporatedBy :> BinaryConnection {
    end source : Anything :>> BinaryConnection::source;
    end target : Anything :>> BinaryConnection::target;
  }

  connection def Incorporates :> BinaryConnection {
    end source : Anything :>> BinaryConnection::source;
    end target : Anything :>> BinaryConnection::target;
  }

  connection def InputTo :> BinaryConnection {
    end source : Anything :>> BinaryConnection::source;
    end target : Anything :>> BinaryConnection::target;
  }

  connection def Inputs :> BinaryConnection {
    end source : Anything :>> BinaryConnection::source;
    end target : Anything :>> BinaryConnection::target;
  }

  connection def Involves :> BinaryConnection {
    end source : Anything :>> BinaryConnection::source;
    end target : Anything :>> BinaryConnection::target;
  }

  connection def OutputFrom :> BinaryConnection {
    end source : Anything :>> BinaryConnection::source;
    end target : Anything :>> BinaryConnection::target;
  }

  connection def Outputs :> BinaryConnection {
    end source : Anything :>> BinaryConnection::source;
    end target : Anything :>> BinaryConnection::target;
  }

  connection def Performs :> BinaryConnection {
    end source : Anything :>> BinaryConnection::source;
    end target : Anything :>> BinaryConnection::target;
  }

  connection def RefinedBy :> BinaryConnection {
    end source : Anything :>> BinaryConnection::source;
    end target : Anything :>> BinaryConnection::target;
  }

  connection def Resolves :> BinaryConnection {
    end source : Anything :>> BinaryConnection::source;
    end target : Anything :>> BinaryConnection::target;
  }

  connection def ResponsibleFor :> BinaryConnection {
    end source : Anything :>> BinaryConnection::source;
    end target : Anything :>> BinaryConnection::target;
  }

  connection def ResultOf :> BinaryConnection {
    end source : Anything :>> BinaryConnection::source;
    end target : Anything :>> BinaryConnection::target;
  }

  connection def ResultsIn :> BinaryConnection {
    end source : Anything :>> BinaryConnection::source;
    end target : Anything :>> BinaryConnection::target;
  }

  connection def Services :> BinaryConnection {
    end source : Anything :>> BinaryConnection::source;
    end target : Anything :>> BinaryConnection::target;
  }

  connection def SpecifiedBy :> BinaryConnection {
    end source : Anything :>> BinaryConnection::source;
    end target : Anything :>> BinaryConnection::target;
  }

  connection def Specifies :> BinaryConnection {
    end source : Anything :>> BinaryConnection::source;
    end target : Anything :>> BinaryConnection::target;
  }

  connection def SuppliedBy :> BinaryConnection {
    end source : Anything :>> BinaryConnection::source;
    end target : Anything :>> BinaryConnection::target;
  }

  connection def Supplies :> BinaryConnection {
    end source : Anything :>> BinaryConnection::source;
    end target : Anything :>> BinaryConnection::target;
  }

  connection def TransferredBy :> BinaryConnection {
    end source : Anything :>> BinaryConnection::source;
    end target : Anything :>> BinaryConnection::target;
  }

  connection def Transfers :> BinaryConnection {
    end source : Anything :>> BinaryConnection::source;
    end target : Anything :>> BinaryConnection::target;
  }

  connection def TriggeredBy :> BinaryConnection {
    end source : Anything :>> BinaryConnection::source;
    end target : Anything :>> BinaryConnection::target;
  }

  connection def Triggers :> BinaryConnection {
    end source : Anything :>> BinaryConnection::source;
    end target : Anything :>> BinaryConnection::target;
  }

  connection def UsedIn :> BinaryConnection {
    end source : Anything :>> BinaryConnection::source;
    end target : Anything :>> BinaryConnection::target;
  }

  connection def Uses :> BinaryConnection {
    end source : Anything :>> BinaryConnection::source;
    end target : Anything :>> BinaryConnection::target;
  }

}


