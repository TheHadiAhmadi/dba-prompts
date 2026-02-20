
import { call, getSql, saveJson } from "./shared.js"

const systemPrompt = `
You are a senior database expert. 

Review the following schema design. Focus only on normalization and denormalization issues, including:

- Redundant or duplicate data.
- Missing relationships that cause anomalies.
- Over-normalization that could hurt performance.
- Tables or columns that could benefit from denormalization for efficiency.

Provide actionable suggestions for improvements.

Output must be a single JSON object in the following format:

{
  "notes": [
    { 
      "content": "string",
      "priority": 1 | 2 | 3 | 4 | 5
    }
  ],
  "issues": [
    {
      "table": "string",
      "columns": ["string"] | null,
      "issue": "redundant_data | missing_relation | over_normalization | denormalization_opportunity",
      "priority": 1 | 2 | 3 | 4 | 5,
      "note": "string",
      "suggestedChange": "string",
      "relatedTables": ["string"] | null
    }
  ]
}

- "notes" contains general observations about the schema’s normalization state.  
- "issues" are specific to tables/columns, with type of issue, priority, explanation, and actionable suggestions.  
- Include related tables for missing relationships or denormalization opportunities.  
- Prioritize issues where 1 = critical, 5 = low importance.  
- Do not include any text outside the JSON object.  
`

const result = await call({systemPrompt, userMessage: `Here is the sql file: ` + getSql()})


const json = JSON.parse(result.content)
saveJson('./normalization-result.json', json)