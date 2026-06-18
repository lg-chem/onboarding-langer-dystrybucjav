// Bramka logowania do onboardingu — jeden wspólny kod dostępu.
// Kod ustawiasz w Vercel → Environment Variables jako ONBOARDING_CODE.
// Kod nie trafia do kodu front-endu — weryfikacja jest po stronie serwera.

export default async function handler(req, res) {
  res.setHeader('Cache-Control', 'no-store');

  const configured = !!process.env.ONBOARDING_CODE;

  // GET — czy bramka jest włączona (czy ustawiono kod)?
  if (req.method === 'GET') {
    return res.status(200).json({ gate: configured });
  }

  // POST — weryfikacja kodu
  if (req.method === 'POST') {
    if (!configured) return res.status(200).json({ ok: true, configured: false });
    const { code } = req.body || {};
    if (code && code === process.env.ONBOARDING_CODE) {
      return res.status(200).json({ ok: true });
    }
    return res.status(401).json({ ok: false, error: 'Niepoprawny kod dostępu' });
  }

  res.setHeader('Allow', 'GET, POST');
  return res.status(405).json({ error: 'Method not allowed' });
}
