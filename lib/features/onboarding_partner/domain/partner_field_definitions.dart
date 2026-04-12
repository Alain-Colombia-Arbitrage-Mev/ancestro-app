import '../../../core/auth/auth_user.dart';
import 'models/partner_field_config.dart';

const Map<PartnerType, List<PartnerFieldConfig>> partnerFieldDefinitions = {
  PartnerType.socioInversionista: [
    PartnerFieldConfig(
      key: 'investmentAmount',
      label: 'Investment Amount',
      type: FieldType.dropdown,
      options: [
        '\$10,000 - \$50,000',
        '\$50,000 - \$100,000',
        '\$100,000 - \$500,000',
        '\$500,000+',
      ],
    ),
    PartnerFieldConfig(
      key: 'investmentHorizon',
      label: 'Investment Horizon',
      type: FieldType.dropdown,
      options: [
        '1-3 years',
        '3-5 years',
        '5-10 years',
        '10+ years',
      ],
    ),
    PartnerFieldConfig(
      key: 'previousExperience',
      label: 'Previous Experience',
      type: FieldType.text,
    ),
    PartnerFieldConfig(
      key: 'areasOfInterest',
      label: 'Areas of Interest',
      type: FieldType.multiSelect,
      options: [
        'Solar Energy',
        'EV Infrastructure',
        'Battery Storage',
        'Smart Grid',
        'Green Hydrogen',
      ],
    ),
  ],
  PartnerType.socioEstrategico: [
    PartnerFieldConfig(
      key: 'companyName',
      label: 'Company Name',
      type: FieldType.text,
    ),
    PartnerFieldConfig(
      key: 'sector',
      label: 'Sector',
      type: FieldType.dropdown,
      options: [
        'Technology',
        'Finance',
        'Real Estate',
        'Energy',
        'Construction',
        'Other',
      ],
    ),
    PartnerFieldConfig(
      key: 'allianceProposal',
      label: 'Alliance Proposal',
      type: FieldType.textarea,
    ),
    PartnerFieldConfig(
      key: 'companySize',
      label: 'Company Size',
      type: FieldType.dropdown,
      options: [
        '1-10 employees',
        '11-50 employees',
        '51-200 employees',
        '201-500 employees',
        '500+ employees',
      ],
    ),
  ],
  PartnerType.instaladorCertificado: [
    PartnerFieldConfig(
      key: 'certifications',
      label: 'Certifications',
      type: FieldType.multiSelect,
      options: [
        'NABCEP',
        'UL Certified',
        'OSHA',
        'Electrical License',
        'General Contractor',
      ],
    ),
    PartnerFieldConfig(
      key: 'yearsExperience',
      label: 'Years of Experience',
      type: FieldType.number,
    ),
    PartnerFieldConfig(
      key: 'coverageZones',
      label: 'Coverage Zones',
      type: FieldType.multiSelect,
      options: [
        'North',
        'South',
        'East',
        'West',
        'Central',
        'Metropolitan',
      ],
    ),
    PartnerFieldConfig(
      key: 'portfolioUrl',
      label: 'Portfolio URL',
      type: FieldType.text,
      required: false,
    ),
  ],
  PartnerType.empresaEnergia: [
    PartnerFieldConfig(
      key: 'companyName',
      label: 'Company Name',
      type: FieldType.text,
    ),
    PartnerFieldConfig(
      key: 'serviceTypes',
      label: 'Service Types',
      type: FieldType.multiSelect,
      options: [
        'Solar Installation',
        'EV Charging',
        'Battery Storage',
        'Grid Services',
        'Energy Consulting',
      ],
    ),
    PartnerFieldConfig(
      key: 'installedCapacity',
      label: 'Installed Capacity',
      type: FieldType.text,
    ),
    PartnerFieldConfig(
      key: 'licenses',
      label: 'Licenses',
      type: FieldType.fileUpload,
    ),
  ],
  PartnerType.socioLogistica: [
    PartnerFieldConfig(
      key: 'fleetSize',
      label: 'Fleet Size',
      type: FieldType.number,
    ),
    PartnerFieldConfig(
      key: 'vehicleTypes',
      label: 'Vehicle Types',
      type: FieldType.multiSelect,
      options: [
        'Trucks',
        'Vans',
        'Cars',
        'Electric Vehicles',
        'Specialized',
      ],
    ),
    PartnerFieldConfig(
      key: 'primaryRoutes',
      label: 'Primary Routes',
      type: FieldType.text,
    ),
    PartnerFieldConfig(
      key: 'electrificationInterest',
      label: 'Electrification Interest',
      type: FieldType.dropdown,
      options: [
        'Immediate',
        'Within 1 year',
        'Within 3 years',
        'Exploring options',
      ],
    ),
  ],
  PartnerType.asesorConsultor: [
    PartnerFieldConfig(
      key: 'specialty',
      label: 'Specialty',
      type: FieldType.dropdown,
      options: [
        'Solar Energy',
        'EV Infrastructure',
        'Energy Efficiency',
        'Sustainability',
        'Policy & Regulation',
      ],
    ),
    PartnerFieldConfig(
      key: 'yearsExperience',
      label: 'Years of Experience',
      type: FieldType.number,
    ),
    PartnerFieldConfig(
      key: 'previousClients',
      label: 'Previous Clients',
      type: FieldType.textarea,
    ),
    PartnerFieldConfig(
      key: 'linkedIn',
      label: 'LinkedIn Profile',
      type: FieldType.text,
      required: false,
    ),
  ],
  PartnerType.gobiernoMunicipio: [
    PartnerFieldConfig(
      key: 'entityName',
      label: 'Entity Name',
      type: FieldType.text,
    ),
    PartnerFieldConfig(
      key: 'position',
      label: 'Position',
      type: FieldType.text,
    ),
    PartnerFieldConfig(
      key: 'projectType',
      label: 'Project Type',
      type: FieldType.dropdown,
      options: [
        'Public Solar Installation',
        'EV Charging Network',
        'Smart City Energy',
        'Community Solar',
        'Municipal Fleet Electrification',
      ],
    ),
    PartnerFieldConfig(
      key: 'estimatedBudget',
      label: 'Estimated Budget',
      type: FieldType.dropdown,
      options: [
        'Under \$100,000',
        '\$100,000 - \$500,000',
        '\$500,000 - \$1,000,000',
        '\$1,000,000 - \$5,000,000',
        '\$5,000,000+',
      ],
    ),
    PartnerFieldConfig(
      key: 'timeline',
      label: 'Timeline',
      type: FieldType.dropdown,
      options: [
        'Immediate',
        '3-6 months',
        '6-12 months',
        '1-2 years',
        '2+ years',
      ],
    ),
  ],
};
