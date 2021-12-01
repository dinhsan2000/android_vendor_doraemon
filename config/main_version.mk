# Versioning System
DORA_BUILD_VARIANT ?= Gapps
DORA_BUILD_TYPE ?= UNOFFICIAL
DORA_CODENAME := Beta

# DoraemonOS Release
ifeq ($(DORA_BUILD_TYPE), OFFICIAL)

  OFFICIAL_DEVICES = $(shell cat vendor/dora/dora.devices)
  FOUND_DEVICE =  $(filter $(DORA_BUILD), $(OFFICIAL_DEVICES))
    ifeq ($(FOUND_DEVICE),$(DORA_BUILD))
      DORA_BUILD_TYPE := OFFICIAL
    else
      DORA_BUILD_TYPE := UNOFFICIAL
      $(error Device is not official "$(DORA_BUILD)")
    endif
endif

# System version
TARGET_PRODUCT_SHORT := $(subst dora_,,$(DORA_BUILD_TYPE))

DORA_DATE_YEAR := $(shell date -u +%Y)
DORA_DATE_MONTH := $(shell date -u +%m)
DORA_DATE_DAY := $(shell date -u +%d)
DORA_DATE_HOUR := $(shell date -u +%H)
DORA_DATE_MINUTE := $(shell date -u +%M)
DORA_BUILD_DATE_UTC := $(shell date -d '$(DORA_DATE_YEAR)-$(DORA_DATE_MONTH)-$(DORA_DATE_DAY) $(DORA_DATE_HOUR):$(DORA_DATE_MINUTE) UTC' +%s)
DORA_BUILD_DATE := $(DORA_DATE_YEAR)$(DORA_DATE_MONTH)$(DORA_DATE_DAY)-$(DORA_DATE_HOUR)$(DORA_DATE_MINUTE)

DORA_PLATFORM_VERSION := 12.0

DORAVERSION := 3.1

DORA_VERSION := Doraemon-OS-v$(DORAVERSION)-$(DORA_BUILD_DATE)-$(DORA_BUILD)-$(DORA_BUILD_TYPE)-$(DORA_BUILD_VARIANT)
DORA_VERSION_PROP := $(PLATFORM_VERSION)
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.dora.version=$(DORAVERSION) \
    ro.dora.version.display=$(DORA_VERSION) \
    ro.dora.build_date=$(DORA_BUILD_DATE) \
    ro.dora.codename=$(DORA_CODENAME) \
    ro.dora.version.prop=$(DORA_VERSION_PROP) \
    ro.dora.build_date_utc=$(DORA_BUILD_DATE_UTC) \
    ro.dora.build_type=$(DORA_BUILD_TYPE)
