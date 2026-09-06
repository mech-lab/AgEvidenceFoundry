"""AgEvidence Python SDK.

The SDK orchestrates Rails Developer OS APIs and delegates trust operations to
configured verifier tools. It does not sign receipts, compute receipt
commitments, or verify bundles internally.
"""

from importlib import import_module
from typing import Any

__version__ = "0.1.0"

_LAZY_EXPORTS = {
    "AgEvidenceError": ".errors",
    "AgEvidenceRequest": ".request_models",
    "ActivationPath": ".campaign",
    "ArtifactDownloadMetadata": ".models",
    "ArtifactOrder": ".models",
    "AsyncClient": ".async_client",
    "CampaignAccount": ".campaign",
    "CampaignClient": ".campaign",
    "CampaignContactRef": ".campaign",
    "CampaignDashboard": ".campaign",
    "Client": ".client",
    "CommercialHandoff": ".campaign",
    "CountryAdapterInfo": ".models",
    "CountryAdapterValidation": ".models",
    "CountryDetermination": ".models",
    "DeveloperProject": ".models",
    "EvidenceCandidate": ".models",
    "IntegrationEventStatus": ".models",
    "Operation": ".models",
    "PricingQuote": ".models",
    "ProductCatalog": ".models",
    "RetryPolicy": ".transport",
    "SourceRecord": ".models",
    "TechnicalQualification": ".campaign",
    "WebhookEndpoint": ".models",
}

__all__ = [
    "AgEvidenceError",
    "AgEvidenceRequest",
    "ActivationPath",
    "ArtifactDownloadMetadata",
    "ArtifactOrder",
    "AsyncClient",
    "CampaignAccount",
    "CampaignClient",
    "CampaignContactRef",
    "CampaignDashboard",
    "Client",
    "CommercialHandoff",
    "CountryAdapterInfo",
    "CountryAdapterValidation",
    "CountryDetermination",
    "DeveloperProject",
    "EvidenceCandidate",
    "IntegrationEventStatus",
    "Operation",
    "PricingQuote",
    "ProductCatalog",
    "RetryPolicy",
    "SourceRecord",
    "TechnicalQualification",
    "WebhookEndpoint",
    "__version__",
]


def __getattr__(name: str) -> Any:
    try:
        module_name = _LAZY_EXPORTS[name]
    except KeyError as exc:
        raise AttributeError(f"module {__name__!r} has no attribute {name!r}") from exc

    module = import_module(module_name, __name__)
    value = getattr(module, name)
    globals()[name] = value
    return value


def __dir__() -> list[str]:
    return sorted(set(globals()) | set(__all__))
