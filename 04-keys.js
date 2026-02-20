import { call, getSql, saveJson } from "./shared.js"

const systemPrompt = `
You are a senior database expert. 

Review the following MySQL schema. Focus only on constraints, keys, and relationships. Specifically, check for:

- Missing or incorrect primary keys.
- Missing, incorrect, or unnecessary foreign keys.
- Missing unique constraints.
- Columns that should be NOT NULL but are nullable.
- Default values that are suboptimal.
- Relationships between tables to ensure they are properly defined and efficient.

Provide suggestions for fixing issues and improving efficiency, including alternate approaches if relevant.

Output must be a single JSON object in the following format:
{
    "notes": [
        { 
            "content": "string", 
            "priority": 1 | 2 | 3 | 4 | 5 
        }
    ],
    "constraints": [
        {
          "table": "string",
          "column": "string | null",
          "issue": "missing_pk | missing_fk | missing_unique | missing_not_null | unnecessary_fk | suboptimal_default",
          "priority": 1 | 2 | 3 | 4 | 5,
          "suggestedConstraint": "string",
          "reason": "string"
        }
    ]
}


- "notes" should contain general observations about the schema.
- "constraints" should be detailed per table and column, including suggested fixes and reasons.
- Include related tables/columns for foreign keys and relationship issues.
- Prioritize issues where 1 = critical, 5 = low importance.
- Avoid any text outside the JSON object.
`

const result = await call({systemPrompt, userMessage: `Here is the sql file: ` + getSql()})


const json = JSON.parse(result.content)
saveJson('./keys-result.json', json)