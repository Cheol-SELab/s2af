
package Level2DomainTypes {
  private import ScalarValues::String;
  private import Base::Anything;
  private import Requirements::RequirementCheck;
  private import Connections::BinaryConnection;
  private import Allocations::Allocation;
  private import Metadata::MetadataItem;
  private import Level1BaseTypes::*;

  // Metadata type for relationship specifications
  metadata def RelationshipSpec :> MetadataItem {
    attribute targetTypes : String[0..*];
  }

  // ========== Level 2 Element Types with Relationship Specifications ==========

  part def Category :> AbstractManagement {
    metadata def Categorizes :> RelationshipSpec {
      targetTypes = ("Requirement");
    }
    metadata def Includes :> RelationshipSpec {
      targetTypes = ("Category");
    }
  }

  part def ModificationBundle :> AbstractManagement {
    metadata def AssignedTo :> RelationshipSpec {
      targetTypes = ("Organization");
    }
    metadata def AugmentedBy :> RelationshipSpec {
      targetTypes = ("Attachment");
    }
    metadata def DocumentedBy :> RelationshipSpec {
      targetTypes = ("Document");
    }
    metadata def GeneratedBy :> RelationshipSpec {
      targetTypes = ("Component", "Document", "Function", "Link", "CountermeasureAction", "Organization", "Requirement", "Resource", "State", "Scenario", "VerificationCriterion");
    }
    metadata def Impacts :> RelationshipSpec {
      targetTypes = ("Component", "Document", "Function", "Item", "Link", "Mode", "Organization", "Product", "ProjectAction", "ProjectUnit", "Requirement", "Resource", "State", "EvaluationSetup", "EvaluationArtifact", "Scenario", "VerificationAction", "VerificationMilestone", "VerificationCriterion");
    }
    metadata def OriginatedBy :> RelationshipSpec {
      targetTypes = ("Organization");
    }
    metadata def ResultsIn :> RelationshipSpec {
      targetTypes = ("Function", "Requirement");
    }
  }

  part def Component :> AbstractStructure {
    metadata def BuiltFrom_BuiltIn :> RelationshipSpec {
      targetTypes = ("Component");
    }
    metadata def ConnectedTo :> RelationshipSpec {
      targetTypes = ("Link");
    }
    metadata def Documents :> RelationshipSpec {
      targetTypes = ("Document");
    }
    metadata def Exhibits :> RelationshipSpec {
      targetTypes = ("State");
    }
    metadata def Exposes :> RelationshipSpec {
      targetTypes = ("Port");
    }
    metadata def Generates :> RelationshipSpec {
      targetTypes = ("ModificationBundle", "Concern", "Risk");
    }
    metadata def ImpactedBy :> RelationshipSpec {
      targetTypes = ("ModificationBundle", "CountermeasureAction", "Risk");
    }
    metadata def Includes :> RelationshipSpec {
      targetTypes = ("Mode");
    }
    metadata def ParticipatesIn :> RelationshipSpec {
      targetTypes = ("Scenario");
    }
    metadata def Performs :> RelationshipSpec {
      targetTypes = ("Function");
    }
    metadata def SpecifiedBy :> RelationshipSpec {
      targetTypes = ("Requirement");
    }
  }

  part def Concern :> AbstractManagement {
    metadata def AssignedTo :> RelationshipSpec {
      targetTypes = ("Organization");
    }
    metadata def AugmentedBy :> RelationshipSpec {
      targetTypes = ("Attachment");
    }
    metadata def DocumentedBy :> RelationshipSpec {
      targetTypes = ("Document");
    }
    metadata def Forms :> RelationshipSpec {
      targetTypes = ("EvaluationSetup");
    }
    metadata def GeneratedBy :> RelationshipSpec {
      targetTypes = ("Component", "Function", "Link", "Requirement");
    }
    metadata def Generates :> RelationshipSpec {
      targetTypes = ("VerificationAction");
    }
    metadata def ResultsIn :> RelationshipSpec {
      targetTypes = ("Function", "Requirement");
    }
  }

  part def Glossary :> AbstractManagement {}

  part def Document :> AbstractManagement {
    metadata def Documents :> RelationshipSpec {
      targetTypes = ("ModificationBundle", "Component", "Concern", "Link", "Mode", "Requirement", "Risk", "State", "EvaluationSetup", "VerificationAction", "VerificationMilestone");
    }
    metadata def Generates :> RelationshipSpec {
      targetTypes = ("ModificationBundle");
    }
    metadata def ImpactedBy :> RelationshipSpec {
      targetTypes = ("ModificationBundle");
    }
    metadata def Uses :> RelationshipSpec {
      targetTypes = ("Glossary");
    }
  }

  part def Entity :> AbstractStructure {}

  action def Event :> AbstractBehavior {
    metadata def DocumentedBy :> RelationshipSpec {
      targetTypes = ("Document");
    }
    metadata def ResponsibleFor :> RelationshipSpec {
      targetTypes = ("Item");
    }
    metadata def Triggers :> RelationshipSpec {
      targetTypes = ("Transition");
    }
  }

  part def Attachment :> AbstractManagement {
    metadata def Augments :> RelationshipSpec {
      targetTypes = ("ModificationBundle", "Concern", "Port", "Requirement", "SpecificationSet", "Risk", "State", "EvaluationSetup", "EvaluationArtifact", "VerificationAction", "VerificationMilestone");
    }
  }

  action def Function :> AbstractBehavior {
    metadata def AllocatedTo :> RelationshipSpec {
      targetTypes = ("Component");
    }
    metadata def BasedOn :> RelationshipSpec {
      targetTypes = ("Requirement");
    }
    metadata def Causes :> RelationshipSpec {
      targetTypes = ("Risk");
    }
    metadata def DecomposedBy :> RelationshipSpec {
      targetTypes = ("Function");
    }
    metadata def Generates :> RelationshipSpec {
      targetTypes = ("ModificationBundle", "Concern");
    }
    metadata def ImpactedBy :> RelationshipSpec {
      targetTypes = ("ModificationBundle", "CountermeasureAction", "Risk");
    }
    metadata def IncorporatedBy :> RelationshipSpec {
      targetTypes = ("State");
    }
    metadata def Inputs :> RelationshipSpec {
      targetTypes = ("Item");
    }
    metadata def Outputs :> RelationshipSpec {
      targetTypes = ("Item");
    }
    metadata def ResultOf :> RelationshipSpec {
      targetTypes = ("Concern");
    }
    metadata def Services :> RelationshipSpec {
      targetTypes = ("Transition");
    }
    metadata def SpecifiedBy :> RelationshipSpec {
      targetTypes = ("Requirement");
    }
    metadata def VerifiedBy :> RelationshipSpec {
      targetTypes = ("VerificationCriterion");
    }
  }

  part def Item :> AbstractStructure {
    metadata def AssignedTo :> RelationshipSpec {
      targetTypes = ("Event");
    }
    metadata def DecomposedBy :> RelationshipSpec {
      targetTypes = ("Item");
    }
    metadata def ImpactedBy :> RelationshipSpec {
      targetTypes = ("ModificationBundle", "CountermeasureAction", "Risk");
    }
    metadata def InputTo :> RelationshipSpec {
      targetTypes = ("Function", "VerificationAction");
    }
    metadata def OutputFrom :> RelationshipSpec {
      targetTypes = ("Function");
    }
    metadata def TransferredBy :> RelationshipSpec {
      targetTypes = ("Link");
    }
  }

  part def Link :> AbstractStructure {
    metadata def ConnectsTo :> RelationshipSpec {
      targetTypes = ("Component");
    }
    metadata def DocumentedBy :> RelationshipSpec {
      targetTypes = ("Document");
    }
    metadata def Forms :> RelationshipSpec {
      targetTypes = ("EvaluationSetup");
    }
    metadata def Generates :> RelationshipSpec {
      targetTypes = ("ModificationBundle", "Concern");
    }
    metadata def ImpactedBy :> RelationshipSpec {
      targetTypes = ("ModificationBundle", "CountermeasureAction", "Risk");
    }
    metadata def Includes :> RelationshipSpec {
      targetTypes = ("Link");
    }
    metadata def SpecifiedBy :> RelationshipSpec {
      targetTypes = ("Requirement");
    }
    metadata def Transfers :> RelationshipSpec {
      targetTypes = ("Item");
    }
  }

  part def CountermeasureAction :> AbstractManagement {
    metadata def DecomposedBy :> RelationshipSpec {
      targetTypes = ("CountermeasureAction");
    }
    metadata def GeneratedBy :> RelationshipSpec {
      targetTypes = ("ModificationBundle");
    }
    metadata def Impacts :> RelationshipSpec {
      targetTypes = ("Component", "Function", "Item", "Link", "CountermeasureAction", "Organization", "Product", "ProjectAction", "ProjectUnit", "Requirement", "Risk", "EvaluationArtifact", "VerificationAction", "VerificationCriterion");
    }
    metadata def Mitigates :> RelationshipSpec {
      targetTypes = ("Risk");
    }
  }

  action def Mode :> AbstractBehavior {
    metadata def ContainedBy :> RelationshipSpec {
      targetTypes = ("Component");
    }
    metadata def DocumentedBy :> RelationshipSpec {
      targetTypes = ("Document");
    }
    metadata def Encompasses :> RelationshipSpec {
      targetTypes = ("State");
    }
    metadata def SpecifiedBy :> RelationshipSpec {
      targetTypes = ("Requirement");
    }
  }

  part def Junction :> AbstractStructure {}

  part def Note :> AbstractManagement {
    metadata def CommentsOn :> RelationshipSpec {
      targetTypes = ("Entity");
    }
    metadata def DocumentedBy :> RelationshipSpec {
      targetTypes = ("Document");
    }
    metadata def Identifies :> RelationshipSpec {
      targetTypes = ("Junction", "Risk");
    }
  }

  part def Organization :> AbstractStructure {
    metadata def Generates :> RelationshipSpec {
      targetTypes = ("ModificationBundle");
    }
    metadata def ImpactedBy :> RelationshipSpec {
      targetTypes = ("ModificationBundle", "CountermeasureAction");
    }
    metadata def Originates :> RelationshipSpec {
      targetTypes = ("ModificationBundle");
    }
    metadata def ResponsibleFor :> RelationshipSpec {
      targetTypes = ("Concern", "Risk", "VerificationAction");
    }
  }

  part def Package :> AbstractManagement {}

  part def Port :> AbstractStructure {
    metadata def AugmentedBy :> RelationshipSpec {
      targetTypes = ("Attachment", "Text");
    }
    metadata def CategorizedBy :> RelationshipSpec {
      targetTypes = ("Category");
    }
    metadata def DocumentedBy :> RelationshipSpec {
      targetTypes = ("Document");
    }
    metadata def GeneralizationOf :> RelationshipSpec {
      targetTypes = ("Port");
    }
    metadata def Generates :> RelationshipSpec {
      targetTypes = ("Junction", "Risk");
    }
    metadata def ImpactedBy :> RelationshipSpec {
      targetTypes = ("CountermeasureAction", "Risk");
    }
    metadata def IsPortFor :> RelationshipSpec {
      targetTypes = ("Port");
    }
    metadata def PackagedBy :> RelationshipSpec {
      targetTypes = ("Package");
    }
    metadata def Provides :> RelationshipSpec {
      targetTypes = ("InterfaceSpec");
    }
    metadata def Requires :> RelationshipSpec {
      targetTypes = ("InterfaceSpec");
    }
    metadata def SpecifiedBy :> RelationshipSpec {
      targetTypes = ("Requirement");
    }
  }

  part def InterfaceSpec :> AbstractStructure {
    metadata def AugmentedBy :> RelationshipSpec {
      targetTypes = ("Attachment", "Text");
    }
    metadata def CategorizedBy :> RelationshipSpec {
      targetTypes = ("Category");
    }
  }

  part def Product :> AbstractStructure {}

  action def ProjectAction :> AbstractBehavior {}

  action def ProjectUnit :> AbstractBehavior {}

  requirement def Requirement :> AbstractRequirement {
    metadata def AugmentedBy :> RelationshipSpec {
      targetTypes = ("Attachment");
    }
    metadata def BasisOf :> RelationshipSpec {
      targetTypes = ("Function", "VerificationAction");
    }
    metadata def Causes :> RelationshipSpec {
      targetTypes = ("Risk");
    }
    metadata def DocumentedBy :> RelationshipSpec {
      targetTypes = ("Document");
    }
    metadata def Establishes :> RelationshipSpec {
      targetTypes = ("VerificationAction");
    }
    metadata def Generates :> RelationshipSpec {
      targetTypes = ("ModificationBundle", "Concern");
    }
    metadata def GroupedBy :> RelationshipSpec {
      targetTypes = ("SpecificationSet");
    }
    metadata def ImpactedBy :> RelationshipSpec {
      targetTypes = ("ModificationBundle", "CountermeasureAction", "Risk");
    }
    metadata def RefinedBy :> RelationshipSpec {
      targetTypes = ("Requirement");
    }
    metadata def Specifies :> RelationshipSpec {
      targetTypes = ("Component", "Link", "Mode", "State");
    }
    metadata def VerifiedBy :> RelationshipSpec {
      targetTypes = ("VerificationCriterion");
    }
  }

  requirement def SpecificationSet :> AbstractRequirement {
    metadata def AugmentedBy :> RelationshipSpec {
      targetTypes = ("Attachment");
    }
    metadata def DocumentedBy :> RelationshipSpec {
      targetTypes = ("Document");
    }
    metadata def GroupedBy :> RelationshipSpec {
      targetTypes = ("SpecificationSet");
    }
    metadata def Groups :> RelationshipSpec {
      targetTypes = ("Requirement");
    }
  }

  part def Resource :> AbstractStructure {}

  part def Risk :> AbstractManagement {
    metadata def AssignedTo :> RelationshipSpec {
      targetTypes = ("Organization");
    }
    metadata def AugmentedBy :> RelationshipSpec {
      targetTypes = ("Attachment");
    }
    metadata def CausedBy :> RelationshipSpec {
      targetTypes = ("Component", "Function", "Link", "Organization", "ProjectAction", "ProjectUnit", "Requirement");
    }
    metadata def DocumentedBy :> RelationshipSpec {
      targetTypes = ("Document");
    }
    metadata def Generates :> RelationshipSpec {
      targetTypes = ("ModificationBundle");
    }
    metadata def MitigatedBy :> RelationshipSpec {
      targetTypes = ("CountermeasureAction");
    }
  }

  action def State :> AbstractBehavior {
    metadata def AugmentedBy :> RelationshipSpec {
      targetTypes = ("Attachment");
    }
    metadata def DecomposedBy :> RelationshipSpec {
      targetTypes = ("State");
    }
    metadata def DocumentedBy :> RelationshipSpec {
      targetTypes = ("Document");
    }
    metadata def EncompassedBy :> RelationshipSpec {
      targetTypes = ("Mode");
    }
    metadata def EnteredBy :> RelationshipSpec {
      targetTypes = ("Transition");
    }
    metadata def ExhibitedBy :> RelationshipSpec {
      targetTypes = ("Component");
    }
    metadata def ExitedBy :> RelationshipSpec {
      targetTypes = ("Transition");
    }
    metadata def Generates :> RelationshipSpec {
      targetTypes = ("ModificationBundle");
    }
    metadata def ImpactedBy :> RelationshipSpec {
      targetTypes = ("ModificationBundle");
    }
    metadata def Incorporates :> RelationshipSpec {
      targetTypes = ("Function");
    }
  }

  part def EvaluationSetup :> AbstractAssurance {
    metadata def DocumentedBy :> RelationshipSpec {
      targetTypes = ("Document");
    }
    metadata def EmployedBy :> RelationshipSpec {
      targetTypes = ("VerificationAction");
    }
    metadata def FormedBy :> RelationshipSpec {
      targetTypes = ("Component", "Link");
    }
  }

  part def EvaluationArtifact :> AbstractAssurance {
    metadata def AugmentedBy :> RelationshipSpec {
      targetTypes = ("Attachment");
    }
    metadata def DecomposedBy :> RelationshipSpec {
      targetTypes = ("EvaluationArtifact");
    }
    metadata def ImpactedBy :> RelationshipSpec {
      targetTypes = ("ModificationBundle", "CountermeasureAction");
    }
    metadata def InputTo :> RelationshipSpec {
      targetTypes = ("VerificationAction");
    }
  }

  part def Text :> AbstractStructure {}

  action def Transition :> AbstractBehavior {
    metadata def DocumentedBy :> RelationshipSpec {
      targetTypes = ("Document");
    }
    metadata def Enters :> RelationshipSpec {
      targetTypes = ("State");
    }
    metadata def Exits :> RelationshipSpec {
      targetTypes = ("State");
    }
    metadata def TriggeredBy :> RelationshipSpec {
      targetTypes = ("Event");
    }
  }

  action def Scenario :> AbstractBehavior {
    metadata def AugmentedBy :> RelationshipSpec {
      targetTypes = ("Attachment");
    }
    metadata def Describes :> RelationshipSpec {
      targetTypes = ("Component");
    }
    metadata def ElaboratedBy :> RelationshipSpec {
      targetTypes = ("Function", "ProjectAction", "VerificationAction");
    }
    metadata def Elicits :> RelationshipSpec {
      targetTypes = ("Requirement");
    }
    metadata def Extends :> RelationshipSpec {
      targetTypes = ("Scenario");
    }
    metadata def Includes :> RelationshipSpec {
      targetTypes = ("Scenario");
    }
    metadata def Involves :> RelationshipSpec {
      targetTypes = ("Component");
    }
  }

  part def VerificationAction :> AbstractAssurance {
    metadata def Accomplishes :> RelationshipSpec {
      targetTypes = ("VerificationMilestone");
    }
    metadata def AssignedTo :> RelationshipSpec {
      targetTypes = ("Organization");
    }
    metadata def AugmentedBy :> RelationshipSpec {
      targetTypes = ("Attachment");
    }
    metadata def Causes :> RelationshipSpec {
      targetTypes = ("Risk");
    }
    metadata def DecomposedBy :> RelationshipSpec {
      targetTypes = ("VerificationAction");
    }
    metadata def DocumentedBy :> RelationshipSpec {
      targetTypes = ("Document");
    }
    metadata def Elaborates :> RelationshipSpec {
      targetTypes = ("Scenario");
    }
    metadata def Employs :> RelationshipSpec {
      targetTypes = ("EvaluationSetup");
    }
    metadata def EstablishedBy :> RelationshipSpec {
      targetTypes = ("Requirement");
    }
    metadata def Executes :> RelationshipSpec {
      targetTypes = ("VerificationCriterion");
    }
    metadata def Generates :> RelationshipSpec {
      targetTypes = ("Concern", "Risk");
    }
    metadata def ImpactedBy :> RelationshipSpec {
      targetTypes = ("ModificationBundle", "CountermeasureAction");
    }
    metadata def Inputs :> RelationshipSpec {
      targetTypes = ("EvaluationArtifact");
    }
    metadata def Outputs :> RelationshipSpec {
      targetTypes = ("EvaluationArtifact");
    }
  }

  part def VerificationMilestone :> AbstractAssurance {
    metadata def AccomplishedBy :> RelationshipSpec {
      targetTypes = ("VerificationAction");
    }
    metadata def AugmentedBy :> RelationshipSpec {
      targetTypes = ("Attachment");
    }
  }

  part def VerificationSet :> AbstractAssurance {}

  part def VerificationCriterion :> AbstractAssurance {
    metadata def BasedOn :> RelationshipSpec {
      targetTypes = ("VerificationAction");
    }
    metadata def Generates :> RelationshipSpec {
      targetTypes = ("ModificationBundle");
    }
    metadata def GroupedBy :> RelationshipSpec {
      targetTypes = ("VerificationSet");
    }
    metadata def ImpactedBy :> RelationshipSpec {
      targetTypes = ("ModificationBundle", "CountermeasureAction");
    }
    metadata def SpecifiedBy :> RelationshipSpec {
      targetTypes = ("VerificationAction");
    }
    metadata def Verifies :> RelationshipSpec {
      targetTypes = ("Function", "Requirement");
    }
  }

  // ========== Relationship Types (Connection/Allocation Definitions) ==========

  connection def AccomplishedBy :> BinaryConnection {
    end source : Anything :>> BinaryConnection::source;
    end target : Anything :>> BinaryConnection::target;
  }

  connection def Accomplishes :> BinaryConnection {
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

  connection def BuiltFrom_BuiltIn :> BinaryConnection {
    end source : Anything :>> BinaryConnection::source;
    end target : Anything :>> BinaryConnection::target;
  }

  connection def CategorizedBy :> BinaryConnection {
    end source : Anything :>> BinaryConnection::source;
    end target : Anything :>> BinaryConnection::target;
  }

  connection def Categorizes :> BinaryConnection {
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

  connection def CommentsOn :> BinaryConnection {
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

  connection def EmployedBy :> BinaryConnection {
    end source : Anything :>> BinaryConnection::source;
    end target : Anything :>> BinaryConnection::target;
  }

  connection def Employs :> BinaryConnection {
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

  connection def EstablishedBy :> BinaryConnection {
    end source : Anything :>> BinaryConnection::source;
    end target : Anything :>> BinaryConnection::target;
  }

  connection def Establishes :> BinaryConnection {
    end source : Anything :>> BinaryConnection::source;
    end target : Anything :>> BinaryConnection::target;
  }

  connection def Executes :> BinaryConnection {
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

  connection def Exposes :> BinaryConnection {
    end source : Anything :>> BinaryConnection::source;
    end target : Anything :>> BinaryConnection::target;
  }

  connection def Extends :> BinaryConnection {
    end source : Anything :>> BinaryConnection::source;
    end target : Anything :>> BinaryConnection::target;
  }

  connection def FormedBy :> BinaryConnection {
    end source : Anything :>> BinaryConnection::source;
    end target : Anything :>> BinaryConnection::target;
  }

  connection def Forms :> BinaryConnection {
    end source : Anything :>> BinaryConnection::source;
    end target : Anything :>> BinaryConnection::target;
  }

  connection def GeneralizationOf :> BinaryConnection {
    end source : Anything :>> BinaryConnection::source;
    end target : Anything :>> BinaryConnection::target;
  }

  connection def GeneratedBy :> BinaryConnection {
    end source : Anything :>> BinaryConnection::source;
    end target : Anything :>> BinaryConnection::target;
  }

  connection def Generates :> BinaryConnection {
    end source : Anything :>> BinaryConnection::source;
    end target : Anything :>> BinaryConnection::target;
  }

  connection def GroupedBy :> BinaryConnection {
    end source : Anything :>> BinaryConnection::source;
    end target : Anything :>> BinaryConnection::target;
  }

  connection def Groups :> BinaryConnection {
    end source : Anything :>> BinaryConnection::source;
    end target : Anything :>> BinaryConnection::target;
  }

  connection def Identifies :> BinaryConnection {
    end source : Anything :>> BinaryConnection::source;
    end target : Anything :>> BinaryConnection::target;
  }

  connection def ImpactedBy :> BinaryConnection {
    end source : Anything :>> BinaryConnection::source;
    end target : Anything :>> BinaryConnection::target;
  }

  connection def Impacts :> BinaryConnection {
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

  connection def IsPortFor :> BinaryConnection {
    end source : Anything :>> BinaryConnection::source;
    end target : Anything :>> BinaryConnection::target;
  }

  connection def MitigatedBy :> BinaryConnection {
    end source : Anything :>> BinaryConnection::source;
    end target : Anything :>> BinaryConnection::target;
  }

  connection def Mitigates :> BinaryConnection {
    end source : Anything :>> BinaryConnection::source;
    end target : Anything :>> BinaryConnection::target;
  }

  connection def OriginatedBy :> BinaryConnection {
    end source : Anything :>> BinaryConnection::source;
    end target : Anything :>> BinaryConnection::target;
  }

  connection def Originates :> BinaryConnection {
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

  connection def PackagedBy :> BinaryConnection {
    end source : Anything :>> BinaryConnection::source;
    end target : Anything :>> BinaryConnection::target;
  }

  connection def ParticipatesIn :> BinaryConnection {
    end source : Anything :>> BinaryConnection::source;
    end target : Anything :>> BinaryConnection::target;
  }

  connection def Performs :> BinaryConnection {
    end source : Anything :>> BinaryConnection::source;
    end target : Anything :>> BinaryConnection::target;
  }

  connection def Provides :> BinaryConnection {
    end source : Anything :>> BinaryConnection::source;
    end target : Anything :>> BinaryConnection::target;
  }

  connection def RefinedBy :> BinaryConnection {
    end source : Anything :>> BinaryConnection::source;
    end target : Anything :>> BinaryConnection::target;
  }

  connection def Requires :> BinaryConnection {
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

  connection def Uses :> BinaryConnection {
    end source : Anything :>> BinaryConnection::source;
    end target : Anything :>> BinaryConnection::target;
  }

  connection def VerifiedBy :> BinaryConnection {
    end source : Anything :>> BinaryConnection::source;
    end target : Anything :>> BinaryConnection::target;
  }

  connection def Verifies :> BinaryConnection {
    end source : Anything :>> BinaryConnection::source;
    end target : Anything :>> BinaryConnection::target;
  }

}
