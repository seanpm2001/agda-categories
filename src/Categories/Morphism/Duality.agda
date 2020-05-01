{-# OPTIONS --without-K --safe #-}

open import Categories.Category

module Categories.Morphism.Duality {o ℓ e} (C : Category o ℓ e) where

open import Relation.Binary.PropositionalEquality using (_≡_; refl)

open Category C

import Categories.Morphism as M
private
  module Op = M op
open M C

open import Categories.Morphism.Properties C

private
  variable
    A B X Y : Obj
    f g h : A ⇒ B

Mono⇒op-Epi : Mono f → Op.Epi f
Mono⇒op-Epi mono = mono

Epi⇒op-Mono : Epi f → Op.Mono f
Epi⇒op-Mono epi = epi

Iso⇒op-Iso : Iso f g → Op.Iso g f
Iso⇒op-Iso iso = record
  { isoˡ = isoˡ
  ; isoʳ = isoʳ
  }
  where open Iso iso

op-Iso⇒Iso : Op.Iso g f → Iso f g
op-Iso⇒Iso iso = record
  { isoˡ = isoˡ
  ; isoʳ = isoʳ
  }
  where open Op.Iso iso

≅⇒op-≅ : A ≅ B → A Op.≅ B
≅⇒op-≅ A≅B = record
  { from = to
  ; to   = from
  ; iso  = Iso⇒op-Iso iso
  }
  where open _≅_ A≅B

op-≅⇒≅ : A Op.≅ B → A ≅ B
op-≅⇒≅ A≅B = record
  { from = to
  ; to   = from
  ; iso  = op-Iso⇒Iso iso
  }
  where open Op._≅_ A≅B


module DualityConversionProperties where
  private
    Iso⇔op-Iso : ∀(iso : Iso f g) → op-Iso⇒Iso (Iso⇒op-Iso iso) ≡ iso
    Iso⇔op-Iso _ = refl

    ≅⇔op-≅ : ∀(A′ B′ : Obj) → (A′≅B′ : A′ ≅ B′) -> op-≅⇒≅ (≅⇒op-≅ A′≅B′) ≡ A′≅B′
    ≅⇔op-≅ _ _ _ = refl
