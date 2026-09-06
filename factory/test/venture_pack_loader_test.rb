# frozen_string_literal: true

require "minitest/autorun"
require "json"
require_relative "../loaders/company_pack_loader"
require_relative "../loaders/venture_pack_loader"
require_relative "../conformance/factory_contract"
require_relative "../operations/brand_score"
require_relative "../operations/gtm_scorer"
require_relative "../operations/gtm_validator"
require_relative "../operations/claims_checker"
require_relative "../operations/opportunity_hypothesis"
require_relative "../operations/pitch_renderer"
require_relative "../operations/research_staleness"

class VenturePackLoaderTest < Minitest::Test
  ROOT = File.expand_path("../..", __dir__)

  def test_lists_seed_venture_packs
    ids = Factory::VenturePackLoader.new(root: ROOT).ids

    assert_equal %w[aglend fieldproof methaneproof supplierevidence], ids
  end

  def test_lists_seed_company_packs
    ids = Factory::CompanyPackLoader.new(root: ROOT).ids

    assert_equal %w[aglend fieldproof methaneproof supplierevidence], ids
  end

  def test_loads_current_pack_from_environment
    pack = Factory::VenturePack.current(env: { "VENTURE_PACK" => "aglend" }, root: ROOT)

    assert_equal "aglend", pack.id
    assert_equal "lender_evidence_package", pack.term(:artifact)
    assert pack.enabled?(:verification)
  end

  def test_all_seed_packs_satisfy_factory_contract
    assert_empty Factory::FactoryContract.new(root: ROOT).validate
  end

  def test_company_pack_wraps_product_pack
    pack = Factory::CompanyPackLoader.new(root: ROOT).load("supplierevidence")

    assert_equal "supplierevidence", pack.id
    assert_equal "SourceRelay", pack.name
    assert_equal "SupplierEvidence", pack.product_pack.name
    assert_equal "Supplier evidence acceptance network", pack.brand.dig("category", "descriptor")
  end

  def test_brand_score_is_computed_from_naming_tests
    pack = Factory::CompanyPackLoader.new(root: ROOT).load("methaneproof")
    score = Factory::Operations::BrandScore.new(pack)

    assert_equal 23, score.total
    assert_equal 25, score.maximum
  end

  def test_gtm_score_uses_account_components
    pack = Factory::CompanyPackLoader.new(root: ROOT).load("methaneproof")
    rows = Factory::Operations::GtmScorer.new(pack).rows

    assert_equal "sea_forest", rows.first["id"]
    assert_equal 94, rows.first["computed_score"]
    assert_empty Factory::Operations::GtmValidator.new(pack).errors
  end

  def test_opportunity_hypothesis_uses_account_and_company_data
    pack = Factory::CompanyPackLoader.new(root: ROOT).load("methaneproof")
    hypothesis = Factory::Operations::OpportunityHypothesis.new(pack, account_id: "sea_forest").render

    assert_includes hypothesis, "Because Sea Forest"
    assert_includes hypothesis, "MethaneProof can provide methane_evidence_statement"
  end

  def test_research_staleness_counts_current_claims
    pack = Factory::CompanyPackLoader.new(root: ROOT).load("fieldproof")
    staleness = Factory::Operations::ResearchStaleness.new(pack, today: Date.new(2026, 9, 6))

    assert_match(/claims valid/, staleness.render)
    assert_equal 0, staleness.rows.count { |row| row["stale"] }
  end

  def test_claims_checker_passes_empty_generated_copy
    pack = Factory::CompanyPackLoader.new(root: ROOT).load("methaneproof")

    assert_empty Factory::Operations::ClaimsChecker.new(pack).findings
  end

  def test_pitch_renderer_builds_customer_pitch
    pack = Factory::CompanyPackLoader.new(root: ROOT).load("supplierevidence")
    pitch = Factory::Operations::PitchRenderer.new(pack, audience: "customer").render

    assert_includes pitch, "# SourceRelay"
    assert_includes pitch, "Supplier evidence acceptance network"
  end

  def test_commercial_schemas_parse_as_json
    Dir[File.join(ROOT, "commercial/schemas/*.json")].each do |schema|
      assert JSON.parse(File.read(schema)), schema
    end
  end
end
