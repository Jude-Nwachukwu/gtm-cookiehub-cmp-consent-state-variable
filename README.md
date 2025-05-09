# CookieHub CMP Consent State – GTM Variable Template

A Google Tag Manager custom **variable template** for retrieving a user's consent state directly from the [CookieHub CMP](https://www.cookiehub.com/).

Use this template to:

* Evaluate whether a user has granted or denied consent for individual or all consent categories.
* Create consent-aware tags and blocking triggers in GTM.
* Support Consent Mode integrations when CookieHub is deployed outside GTM.

> 🧠 Developed by **Jude Nwachukwu Onyejekwe** for **[DumbData](https://dumbdata.co/)**
> 💬 **[Contact us](https://dumbdata.co/contact-us/)** for support or inquiries


---

## 🚀 How to Import the Template

1. Open your **Google Tag Manager** container.
2. Go to **Templates** → **Variable Templates**.
3. Click **New**, then the 3-dot menu in the top right → **Import**.
4. Select the `template.tpl` file from this repository.
5. Save and name your variable (e.g., `CookieHub CMP Consent State`).

---

## ⚙️ How to Configure the Template

Once imported, the variable configuration screen will present the following fields:

### ✅ Select Consent State Check Type

Choose whether to:

* **All Consent State Check** → Returns the state of all categories (e.g., necessary, preferences, marketing, analytics).
* **Specific Consent State** → Returns the state of a single selected category.

### 📂 Select Consent Category

(Only shown when checking a specific category)

* **Necessary**
* **Preferences**
* **Advertising** (maps to CookieHub's `analytics` category)
* **Marketing**

---

## 🧩 Optional Output Transformation

Enable this if you'd like to transform boolean output into readable labels. Once checked, additional options appear:

### 🔁 Transform "True"

* `granted`
* `accept`

### 🔁 Transform "False"

* `denied`
* `deny`

### ❔ Also Transform "undefined" to "denied"

* If checked, any `undefined` state will return as `denied`.

---

## 🧪 Output Example

### All Consent State Output

```json
{
  "necessary": true,
  "preferences": true,
  "marketing": false,
  "analytics": false
}
```

### Specific Consent (Transformed)

```json
"granted"
```

---

## 👨‍💻 Author

Made with ❤️ by [Jude](https://dumbdata.co/) for [DumbData](https://dumbdata.co/)
Have questions? [Contact us](https://dumbdata.co/contact-us/)

---

## 📄 License

Licensed under the **Apache 2.0 License**
