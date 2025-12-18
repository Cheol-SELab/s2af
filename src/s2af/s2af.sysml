/**
 * S2AF (SysML v2 Aligned Architecture Framework) Metamodel
 * 
 * This metamodel defines the S2AF grid structure through concrete artifacts
 * aligned with SysML v2 perspectives and deliverables.
 * 
 * REUSES types from integrated.sysml (Level1BaseTypes, Level2DomainTypes, Level3ArchitectureTypes)
 * 
 * Structure:
 *   - S2AFBaseTypes: S2AF-specific enumerations and metadata (reuses integrated.sysml base types)
 *   - S2AFGridCellArtifacts: Grid cell artifact types mapping to integrated.sysml types
 *   - S2AFGridModel: Complete grid model
 */

package S2AFBaseTypes {
  private import ScalarValues::String;
  private import ScalarValues::Integer;
  private import ScalarValues::Real;
  private import ScalarValues::Boolean;
  private import Base::Anything;
  private import Metadata::MetadataItem;
  
  // Reuse base types from integrated.sysml
  private import Level1BaseTypes::*;
  private import Level2DomainTypes::*;
  private import Level3ArchitectureTypes::*;

  // ========== S2AF Enumeration Types ==========

  enum def DomainKind {
    enum Strategy;      // Why - Mission intent, strategic goals
    enum Operational;   // What - Operational activities, performers
    enum Service;       // How - Service specifications, interfaces
    enum Resource;      // With What - Systems, platforms, components
    enum Project;       // When - Project structure, workflows
  }

  enum def ConcernKind {
    enum Static;        // Nouns - Structure & Taxonomy
    enum Dynamic;       // Verbs - Processes & Sequences
    enum Contracts;     // Rules - Schemas, KPIs & Constraints
  }

  enum def ArtifactKind {
    enum DefinitionDiagram;
    enum StructureDiagram;
    enum ActivityDiagram;
    enum InteractionDiagram;
    enum StateMachineDiagram;
    enum ParametricDiagram;
    enum DataDefinitionDiagram;
    enum TableView;
  }

  // ========== S2AF Metadata Types ==========

  metadata def GridCellSpec :> MetadataItem {
    attribute gridDomain : DomainKind;  // DomainKind value as string
    attribute gridConcern : ConcernKind;  // ConcernKind value as string
    attribute question : String;
    attribute artifacts : ArtifactKind[1..*];  // ArtifactKind values as strings
  }

  // ========== S2AF Grid Cell Base Type ==========

  doc /* Base type for S2AF grid cell artifacts - extends AbstractStructure from integrated.sysml */
  abstract part def GridCellArtifact :> AbstractStructure {
    attribute domainType : DomainKind;  // DomainKind value as string
    attribute concernType : ConcernKind;  // ConcernKind value as string
    attribute stakeholderQuestion : String;
  }
}

package S2AFGridCellArtifacts {
  private import ScalarValues::String;
  private import ScalarValues::Real;
  private import ScalarValues::Boolean;
  private import Base::Anything;
  private import Connections::BinaryConnection;
  private import Allocations::Allocation;
  
  // Reuse types from integrated.sysml
  private import Level1BaseTypes::*;
  private import Level2DomainTypes::*;
  private import Level3ArchitectureTypes::*;
  private import S2AFBaseTypes::*;

  // ========== Strategy Domain (Why) - Reuses Level3 Capability, Mission ==========

  doc /* Strategy-Static: Capability taxonomy and decomposition
       Reuses: Capability (Level3), Requirement (Level2) */
  part def CapabilityTaxonomy :> GridCellArtifact {
    @GridCellSpec {
      gridDomain = DomainKind::Strategy;
      gridConcern = ConcernKind::Static;
      question = "What capabilities exist and how are they organized?";
      artifacts = (ArtifactKind::DefinitionDiagram, ArtifactKind::StructureDiagram);
    }
    
    // Reuse Capability from Level3ArchitectureTypes
    action capabilities : Capability[0..*];
    // Reuse Requirement from Level2DomainTypes for capability requirements
    requirement capabilityRequirements : Requirement[0..*];
  }

  doc /* Strategy-Dynamic: Mission/capability realization flows
       Reuses: Mission (Level3), OperationalTask (Level3), Scenario (Level2) */
  part def CapabilityRealizationFlow :> GridCellArtifact {
    @GridCellSpec {
      gridDomain = DomainKind::Strategy;
      gridConcern = ConcernKind::Dynamic;
      question = "How are capabilities realized through mission threads?";
      artifacts = (ArtifactKind::ActivityDiagram, ArtifactKind::InteractionDiagram);
    }
    
    // Reuse Mission from Level3ArchitectureTypes
    action missions : Mission[0..*];
    // Reuse OperationalTask from Level3ArchitectureTypes
    action operationalTasks : OperationalTask[0..*];
    // Reuse Scenario from Level2DomainTypes for mission scenarios
    action missionScenarios : Scenario[0..*];
  }

  doc /* Strategy-Contracts: Capability KPIs and success measures
       Reuses: VerificationCriterion (Level2), Requirement (Level2) */
  part def CapabilityContract :> GridCellArtifact {
    @GridCellSpec {
      gridDomain = DomainKind::Strategy;
      gridConcern = ConcernKind::Contracts;
      question = "How are capabilities measured and validated?";
      artifacts = (ArtifactKind::DataDefinitionDiagram, ArtifactKind::ParametricDiagram, ArtifactKind::TableView);
    }
    
    // Reuse VerificationCriterion from Level2DomainTypes for KPIs
    part kpis : VerificationCriterion[0..*];
    // Reuse Requirement from Level2DomainTypes for success measures
    requirement successMeasures : Requirement[0..*];
  }

  // ========== Operational Domain (What) - Reuses Level3 Performer, OperationalActivity, OperationalItem ==========

  doc /* Operational-Static: Performer structure and needlines
       Reuses: Performer (Level3), CommunicationPath (Level3), Organization (Level2) */
  part def PerformerStructure :> GridCellArtifact {
    @GridCellSpec {
      gridDomain = DomainKind::Operational;
      gridConcern = ConcernKind::Static;
      question = "What performers exist and how do they exchange information?";
      artifacts = (ArtifactKind::DefinitionDiagram, ArtifactKind::StructureDiagram);
    }
    
    // Reuse Performer from Level3ArchitectureTypes
    part performers : Performer[0..*];
    // Reuse Organization from Level2DomainTypes
    part organizations : Organization[0..*];
    // Reuse CommunicationPath from Level3ArchitectureTypes for needlines
    part needlines : CommunicationPath[0..*];
  }

  doc /* Operational-Dynamic: Operational activity sequences
       Reuses: OperationalActivity (Level3), Scenario (Level2), Transition (Level2) */
  part def OperationalScenario :> GridCellArtifact {
    @GridCellSpec {
      gridDomain = DomainKind::Operational;
      gridConcern = ConcernKind::Dynamic;
      question = "What do performers do and how do they interact?";
      artifacts = (ArtifactKind::ActivityDiagram, ArtifactKind::InteractionDiagram);
    }
    
    // Reuse OperationalActivity from Level3ArchitectureTypes
    action activities : OperationalActivity[0..*];
    // Reuse Scenario from Level2DomainTypes
    action scenarios : Scenario[0..*];
    // Reuse Transition from Level2DomainTypes for activity transitions
    action transitions : Transition[0..*];
  }

  doc /* Operational-Contracts: Business rules and information standards
       Reuses: OperationalItem (Level3), Item (Level2), Requirement (Level2) */
  part def OperationalContract :> GridCellArtifact {
    @GridCellSpec {
      gridDomain = DomainKind::Operational;
      gridConcern = ConcernKind::Contracts;
      question = "What rules and policies govern operations?";
      artifacts = (ArtifactKind::DataDefinitionDiagram, ArtifactKind::ParametricDiagram, ArtifactKind::TableView);
    }
    
    // Reuse OperationalItem from Level3ArchitectureTypes for information items
    part informationItems : OperationalItem[0..*];
    // Reuse Item from Level2DomainTypes for data items
    part dataItems : Item[0..*];
    // Reuse Requirement from Level2DomainTypes for business rules/policies
    requirement businessRules : Requirement[0..*];
  }

  // ========== Service Domain (How-as-a-Service) - Reuses Level2/Level3 Port, InterfaceSpec, ServiceContract ==========

  doc /* Service-Static: Service specifications and interfaces
       Reuses: Port (Level2), InterfaceSpec (Level2), Component (Level2) */
  part def ServiceCatalog :> GridCellArtifact {
    @GridCellSpec {
      gridDomain = DomainKind::Service;
      gridConcern = ConcernKind::Static;
      question = "What services exist and what interfaces do they expose?";
      artifacts = (ArtifactKind::DefinitionDiagram, ArtifactKind::StructureDiagram);
    }
    
    // Reuse Component from Level2DomainTypes for service specifications
    part services : Component[0..*];
    // Reuse Port from Level2DomainTypes for service ports
    part servicePorts : Port[0..*];
    // Reuse InterfaceSpec from Level2DomainTypes for interface specifications
    part interfaces : InterfaceSpec[0..*];
  }

  doc /* Service-Dynamic: Service orchestration sequences
       Reuses: Function (Level2), Scenario (Level2), Event (Level2) */
  part def ServiceOrchestration :> GridCellArtifact {
    @GridCellSpec {
      gridDomain = DomainKind::Service;
      gridConcern = ConcernKind::Dynamic;
      question = "How do services interact and orchestrate?";
      artifacts = (ArtifactKind::InteractionDiagram, ArtifactKind::ActivityDiagram);
    }
    
    // Reuse Function from Level2DomainTypes for service functions
    action serviceFunctions : Function[0..*];
    // Reuse Scenario from Level2DomainTypes for orchestration scenarios
    action orchestrationScenarios : Scenario[0..*];
    // Reuse Event from Level2DomainTypes for service events
    action serviceEvents : Event[0..*];
  }

  doc /* Service-Contracts: API schemas and SLAs
       Reuses: ServiceContract (Level3), Document (Level2), VerificationCriterion (Level2) */
  part def ServiceContractArtifact :> GridCellArtifact {
    @GridCellSpec {
      gridDomain = DomainKind::Service;
      gridConcern = ConcernKind::Contracts;
      question = "What are the API contracts and service level agreements?";
      artifacts = (ArtifactKind::DataDefinitionDiagram, ArtifactKind::ParametricDiagram, ArtifactKind::TableView);
    }
    
    // Reuse ServiceContract from Level3ArchitectureTypes for API schemas
    part apiSchemas : ServiceContract[0..*];
    // Reuse Document from Level2DomainTypes for SLA documents
    part slaDocuments : Document[0..*];
    // Reuse VerificationCriterion from Level2DomainTypes for SLA constraints
    part slaConstraints : VerificationCriterion[0..*];
  }

  // ========== Resource Domain (With What) - Reuses Level2 Component, Function, State, Link ==========

  doc /* Resource-Static: System configuration and physical interfaces
       Reuses: Component (Level2), Link (Level2), Port (Level2) */
  part def SystemConfiguration :> GridCellArtifact {
    @GridCellSpec {
      gridDomain = DomainKind::Resource;
      gridConcern = ConcernKind::Static;
      question = "What systems exist and how are they connected?";
      artifacts = (ArtifactKind::DefinitionDiagram, ArtifactKind::StructureDiagram);
    }
    
    // Reuse Component from Level2DomainTypes for system resources
    part systems : Component[0..*];
    // Reuse Link from Level2DomainTypes for physical connections
    part physicalLinks : Link[0..*];
    // Reuse Port from Level2DomainTypes for physical interfaces
    part physicalInterfaces : Port[0..*];
  }

  doc /* Resource-Dynamic: Resource function execution and state machines
       Reuses: Function (Level2), State (Level2), Mode (Level2), Transition (Level2) */
  part def ResourceBehavior :> GridCellArtifact {
    @GridCellSpec {
      gridDomain = DomainKind::Resource;
      gridConcern = ConcernKind::Dynamic;
      question = "How do resources behave and what states do they exhibit?";
      artifacts = (ArtifactKind::InteractionDiagram, ArtifactKind::StateMachineDiagram);
    }
    
    // Reuse Function from Level2DomainTypes for resource functions
    action resourceFunctions : Function[0..*];
    // Reuse State from Level2DomainTypes for resource states
    action resourceStates : State[0..*];
    // Reuse Mode from Level2DomainTypes for operational modes
    action operationalModes : Mode[0..*];
    // Reuse Transition from Level2DomainTypes for state transitions
    action stateTransitions : Transition[0..*];
  }

  doc /* Resource-Contracts: Technical standards and physical data models
       Reuses: Document (Level2), Item (Level2), VerificationCriterion (Level2) */
  part def ResourceContract :> GridCellArtifact {
    @GridCellSpec {
      gridDomain = DomainKind::Resource;
      gridConcern = ConcernKind::Contracts;
      question = "What standards and data models govern resources?";
      artifacts = (ArtifactKind::DataDefinitionDiagram, ArtifactKind::ParametricDiagram, ArtifactKind::TableView);
    }
    
    // Reuse Document from Level2DomainTypes for technical standards
    part technicalStandards : Document[0..*];
    // Reuse Item from Level2DomainTypes for physical data models
    part physicalDataModels : Item[0..*];
    // Reuse VerificationCriterion from Level2DomainTypes for compliance criteria
    part complianceCriteria : VerificationCriterion[0..*];
  }

  // ========== Project Domain (When) - Reuses Level2 ProjectAction, ProjectUnit, Organization ==========

  doc /* Project-Static: Project/WBS decomposition and team structure
       Reuses: ProjectUnit (Level2), Organization (Level2) */
  part def ProjectStructure :> GridCellArtifact {
    @GridCellSpec {
      gridDomain = DomainKind::Project;
      gridConcern = ConcernKind::Static;
      question = "How is the project organized and who is responsible?";
      artifacts = (ArtifactKind::DefinitionDiagram);
    }
    
    // Reuse ProjectUnit from Level2DomainTypes for project/WBS elements
    action projectUnits : ProjectUnit[0..*];
    // Reuse Organization from Level2DomainTypes for team structure
    part teams : Organization[0..*];
  }

  doc /* Project-Dynamic: Project workflows and roadmaps
       Reuses: ProjectAction (Level2), Scenario (Level2) */
  part def ProjectWorkflow :> GridCellArtifact {
    @GridCellSpec {
      gridDomain = DomainKind::Project;
      gridConcern = ConcernKind::Dynamic;
      question = "What is the project schedule and critical path?";
      artifacts = (ArtifactKind::ActivityDiagram);
    }
    
    // Reuse ProjectAction from Level2DomainTypes for project activities
    action projectActivities : ProjectAction[0..*];
    // Reuse Scenario from Level2DomainTypes for project scenarios/roadmaps
    action projectScenarios : Scenario[0..*];
  }

  doc /* Project-Contracts: Definition of Done and acceptance criteria
       Reuses: VerificationAction (Level2), VerificationMilestone (Level2), VerificationCriterion (Level2) */
  part def ProjectContract :> GridCellArtifact {
    @GridCellSpec {
      gridDomain = DomainKind::Project;
      gridConcern = ConcernKind::Contracts;
      question = "What are the acceptance criteria for each milestone?";
      artifacts = (ArtifactKind::TableView, ArtifactKind::ParametricDiagram);
    }
    
    // Reuse VerificationMilestone from Level2DomainTypes for project milestones
    part milestones : VerificationMilestone[0..*];
    // Reuse VerificationCriterion from Level2DomainTypes for Definition of Done
    part definitionsOfDone : VerificationCriterion[0..*];
    // Reuse VerificationAction from Level2DomainTypes for acceptance activities
    part acceptanceActivities : VerificationAction[0..*];
  }
}

package S2AFGridModel {
  private import ScalarValues::String;
  
  // Reuse types from integrated.sysml
  private import Level1BaseTypes::*;
  private import Level2DomainTypes::*;
  private import Level3ArchitectureTypes::*;
  private import S2AFBaseTypes::*;
  private import S2AFGridCellArtifacts::*;

  doc /* Complete S2AF Grid Model containing all domain × concern cells
       Extends Architecture from Level3ArchitectureTypes */
  part def S2AFGrid :> Architecture {
    doc /* The S2AF Grid organizes architectural knowledge across five domain rows and three concern columns */
    
    // Strategy Domain (Why)
    part strategyStatic : CapabilityTaxonomy;
    part strategyDynamic : CapabilityRealizationFlow;
    part strategyContracts : CapabilityContract;
    
    // Operational Domain (What)
    part operationalStatic : PerformerStructure;
    part operationalDynamic : OperationalScenario;
    part operationalContracts : OperationalContract;
    
    // Service Domain (How)
    part serviceStatic : ServiceCatalog;
    part serviceDynamic : ServiceOrchestration;
    part serviceContracts : ServiceContractArtifact;
    
    // Resource Domain (With What)
    part resourceStatic : SystemConfiguration;
    part resourceDynamic : ResourceBehavior;
    part resourceContracts : ResourceContract;
    
    // Project Domain (When)
    part projectStatic : ProjectStructure;
    part projectDynamic : ProjectWorkflow;
    part projectContracts : ProjectContract;
  }

  doc /* S2AF Architecture Description instance */
  part s2afArchitecture : S2AFGrid {
    attribute id = "S2AF-ARCH-001";
    attribute name = "S2AF Architecture Description";
    attribute description = "Complete S2AF grid-based architecture description";
    attribute version = "1.0";
  }
}
