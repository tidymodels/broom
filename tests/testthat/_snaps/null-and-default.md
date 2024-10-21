# tidy.default

    Code
      td <- tidy(raw(1))
    Condition
      Error:
      ! No tidy method for objects of class raw

---

    Code
      glance(x)
    Condition
      Error:
      ! No glance method for objects of class foo

---

    Code
      glance(x)
    Condition
      Error:
      ! No glance method for objects of class foo

# glance.default

    Code
      glance(TRUE)
    Condition
      Error:
      ! No glance method for objects of class logical

---

    Code
      glance(1)
    Condition
      Error:
      ! No glance method for objects of class numeric

---

    Code
      glance(1L)
    Condition
      Error:
      ! No glance method for objects of class integer

---

    Code
      glance("a")
    Condition
      Error:
      ! No glance method for objects of class character

---

    Code
      glance(x)
    Condition
      Error:
      ! No glance method for objects of class foo

---

    Code
      glance(x)
    Condition
      Error:
      ! No glance method for objects of class foo

# augment.default

    Code
      augment(TRUE)
    Condition
      Error:
      ! No augment method for objects of class logical

---

    Code
      augment(1)
    Condition
      Error:
      ! No augment method for objects of class numeric

---

    Code
      augment(1L)
    Condition
      Error:
      ! No augment method for objects of class integer

---

    Code
      augment("a")
    Condition
      Error:
      ! No augment method for objects of class character

---

    Code
      augment(x)
    Condition
      Error:
      ! No augment method for objects of class foo

---

    Code
      augment(x)
    Condition
      Error:
      ! No augment method for objects of class foo

