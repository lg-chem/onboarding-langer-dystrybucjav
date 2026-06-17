import { neon } from '@neondatabase/serverless';

const sql = neon(process.env.DATABASE_URL);

function requireAdmin(req) {
  const auth = req.headers.authorization || '';
  const expected = `Bearer ${process.env.ADMIN_SECRET}`;
  return process.env.ADMIN_SECRET && auth === expected;
}

export default async function handler(req, res) {
  res.setHeader('Cache-Control', 'no-store');

  try {
    if (req.method === 'GET') {
      const { module } = req.query;
      const rows = (module !== undefined && module !== '')
        ? await sql`
            SELECT id, module, topic, front, back, tags, sort_order
            FROM onboarding_cards
            WHERE module = ${Number(module)}
            ORDER BY sort_order, id`
        : await sql`
            SELECT id, module, topic, front, back, tags, sort_order
            FROM onboarding_cards
            ORDER BY module, sort_order, id`;
      return res.status(200).json(rows);
    }

    if (req.method === 'POST') {
      if (!requireAdmin(req)) return res.status(401).json({ error: 'Unauthorized' });

      const body = req.body || {};
      const { module, topic, front, back, tags, sort_order } = body;
      if (module === undefined || module === null || !front || !back) {
        return res.status(400).json({ error: 'Brak wymaganych pól: module, front, back' });
      }

      const rows = await sql`
        INSERT INTO onboarding_cards (module, topic, front, back, tags, sort_order)
        VALUES (${Number(module)}, ${topic || null}, ${front}, ${back},
                ${tags || []}, ${sort_order || 0})
        RETURNING id, module, topic, front, back, tags, sort_order
      `;
      return res.status(200).json(rows[0]);
    }

    res.setHeader('Allow', 'GET, POST');
    return res.status(405).json({ error: 'Method not allowed' });
  } catch (e) {
    console.error('API /onboarding/cards error:', e);
    return res.status(500).json({ error: e.message || 'Internal error' });
  }
}
